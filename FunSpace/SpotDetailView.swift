//
//  SpotDetailView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/28.
//

import SwiftUI
import MapKit

struct SpotDetailView: View {
    let spot: ScenicSpot
    let position: Position

    @State private var image: UIImage?
    @State private var showFullDescription = false

    init(spot: ScenicSpot) {
        self.spot = spot
        self.position = spot.position!
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if image == nil {
                    Image("ErrorImage")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                } else {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                }

                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.title)
                        .bold()

                    Divider()

                    Text(spot.descriptionDetail ?? "No description...")
                        .font(.callout)
                        .lineLimit(showFullDescription ? nil : 3)

                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                    }
                    .padding(.top, 4)

                    Divider()

                    HStack(spacing: 10) {
                        DetailSectionView(spot: spot, title: "Phone: ") {
                            Text(spot.phone ?? "No contact information.")
                        }

                        DetailSectionView(spot: spot, title: "Website: ") {
                            if spot.websiteURL != nil {
                                Link("Official website", destination: URL(string: spot.websiteURL!)!)
                            } else {
                                Text("Not provide.")
                            }
                        }
                    }

                    DetailSectionView(spot: spot, title: "Open time: ") {
                        Text(spot.openTime ?? "No information.")
                    }

                    Divider()

                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: position.location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [position]) { position in
                        MapAnnotation(coordinate: position.location) {
                            LocationMapAnnotationView()
                        }
                    }
                    .allowsHitTesting(false)
                    .aspectRatio(1.0, contentMode: .fit)
                    .cornerRadius(10)

                }
                .padding([.leading, .trailing])
            }
        }
        .navigationTitle(spot.scenicSpotName ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchImage(url: spot.picture?.pictureUrl1 ?? "")
        }
    }

    func fetchImage(url: String) {
        guard let url = URL(string: url) else { return }

        DispatchQueue.global().async {
            NetworkManager.shared.fetchImage(url: url) { image in
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpotDetailView(spot: ScenicSpot.preview)
        }
    }
}
