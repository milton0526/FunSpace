//
//  ActivityCardView.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/27.
//

import SwiftUI

struct ActivityCardView: View {
    let city: String
    @State private var activities = [Activity]()

    var body: some View {
        List {
            ForEach(activities) { activity in
                VStack(alignment: .leading) {
                    Text(activity.activityName ?? "")
                        .font(.headline)

                    Text(activity.startTime ?? "")
                }
            }
        }
        .navigationTitle(city)
        .onAppear {
            fetch(city: city)
        }
    }

    func fetch(city: String) {
        NetworkManager.shared.fetchActivity(city: city) { (data: [Activity]?) in
            if let data = data {
                activities = data
                activities.sort(by: { $0.startTime! < $1.startTime! })

            }
        }
    }
}

struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivityCardView(city: "Taipei")
        }
    }
}

extension Date {
    func displayDate() {
        let formatter = DateFormatter()
        
    }

}
