//
//  HomeView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/25.
//

import SwiftUI

struct HomeView: View {
    var gridItem = [
        GridItem(.adaptive(minimum: 160)),
        GridItem(.adaptive(minimum: 160))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItem) {
                    ForEach(CityCardView.allCity, id: \.self) { city in
                        NavigationLink {
                            ScenicSpotsView(city: city)
                        } label: {
                            CityCardView(cityName: city)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose City")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
