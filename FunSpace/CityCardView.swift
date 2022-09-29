//
//  CityCardView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/27.
//

import SwiftUI

struct CityCardView: View {
    let cityName: String

    static let allCity = [
        "Taipei", "NewTaipei", "Taoyuan", "Taichung", "Tainan",
        "Kaohsiung", "YilanCounty", "HualienCounty"
    ]

    var body: some View {
        Image(cityName)
            .resizable()
            .scaledToFill()
            .frame(width: 160, height: 200)
            .cornerRadius(15)
            .shadow(radius: 5)
            .overlay {
                Text(cityName)
                    .lineLimit(1)
                    .minimumScaleFactor(0.25)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding()
            }
    }
}

struct CityCardView_Previews: PreviewProvider {
    static var previews: some View {
        CityCardView(cityName: "Taipei")
    }
}
