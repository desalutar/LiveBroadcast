//
//  UserAccountStatictics.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 22.08.24.
//

import SwiftUI


struct StatisticsView: View {
    var userAccountStatistics = [
        "Viewings", "Number of broadcast subscriptions",
        "Max total viewers", "People sharing ",
        "Maximum count of likes from one viewer ",
        "Max gifts count", "Maximum count of comments",
        "Maximum comments from one viewer"
    ]
    var numbers = [200, 450, 890, 322, 13, 35, 99]
    var body: some View {
        List {
            ForEach(Array(zip(userAccountStatistics, 
                              numbers)), id: \.0) { stat, num in
                HStack {
                    Text(stat)
                    Spacer()
                    Text("\(num)")
                }
            }
        }
    }
}

#Preview {
    StatisticsView()
}
