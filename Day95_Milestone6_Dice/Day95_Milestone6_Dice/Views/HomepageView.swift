//
//  homepage.swift
//  Day95_Milestone6_Dice
//
//  Created by T  on 2021-01-19.
//

import SwiftUI

struct HomepageView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
                    RollView()
                        .tabItem {
                            Image(systemName: "play.circle")
                            Text("Roll")
                        }
                        .tag(1)
                    LogView()
                        .tabItem {
                            Image(systemName: "doc.text")
                            Text("Log")
                        }
                        .tag(2)
                })
    }
}


struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
