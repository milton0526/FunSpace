//
//  SpotCardView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/28.
//

import SwiftUI

struct SpotCardView: View {
    let spot: ScenicSpot

    @State private var image: UIImage?

    var body: some View {
        HStack {
            if image == nil {
                Image("ErrorImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 50)
                    .clipped()
                    .cornerRadius(5)

            } else {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 50)
                    .clipped()
                    .cornerRadius(5)
            }

            VStack(alignment: .leading) {
                Text(spot.scenicSpotName ?? "")
                    .lineLimit(2)
                    .minimumScaleFactor(0.2)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
            }
        }
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

struct SpotCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpotCardView(spot: ScenicSpot.preview)
    }
}

