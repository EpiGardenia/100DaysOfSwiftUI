//
//  TabViews.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-01.
//

import SwiftUI

struct TabViews: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
                    Text(String(self.selectedTab)).tabItem {
                        Image(systemName: "star")
                        Text("One")
                    }.tag(1)
                    Text(String(self.selectedTab)).tabItem {
                        Image(systemName: "star.fill")
                        Text("Two")
                    }.tag(2)
                })
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
