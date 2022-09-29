//
//  DetailSectionView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/28.
//

import SwiftUI

struct DetailSectionView<Content: View>: View {
    let spot: ScenicSpot
    let title: String
    let detail: Content

    init(spot: ScenicSpot, title: String, @ViewBuilder detail: () -> Content) {
        self.spot = spot
        self.title = title
        self.detail = detail()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.black)
                .foregroundColor(.gray)
                .padding(.bottom, 2)

            detail
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

struct DetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSectionView(spot: ScenicSpot.preview, title: "Phone:") {
            Text("Some detail...")
        }
    }
}
