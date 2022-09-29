//
//  ScenicSpotsView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/28.
//

import SwiftUI

struct ScenicSpotsView: View {
    let city: String

    @State private var allSpots = [ScenicSpot]()

    var body: some View {
        List {
            ForEach(allSpots) { spot in
                NavigationLink {
                    SpotDetailView(spot: spot)
                } label: {
                    SpotCardView(spot: spot)
                }
            }
            .listRowSeparatorTint(.brown)
        }
        .navigationTitle(city)
        .onAppear {
            fetch(city: city)
        }
    }

    func fetch(city: String) {
        guard let url = URL(string: "https://tdx.transportdata.tw/api/basic/v2/Tourism/ScenicSpot/\(city)?%24top=50&%24format=JSON") else { return }

        DispatchQueue.global().async {
            NetworkManager.shared.fetch(city: city, url: url) { (data: [ScenicSpot]?) in
                if let data = data {
                    DispatchQueue.main.async {
                        allSpots = data
                    }
                }
            }
        }
    }
}

struct ScenicSpotsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScenicSpotsView(city: "Taipei")
        }
    }
}
