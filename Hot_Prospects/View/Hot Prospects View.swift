//
//  Hot Prospects Viewswift.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-05.
//

import SwiftUI

struct Hot_Prospects_View: View {
    var prospects = Prospects()
    var body: some View {
        TabView{
            ProspectView(filter: .none)
                .tabItem{
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectView(filter: .contacted)
                .tabItem{
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectView(filter: .uncontacted)
                .tabItem{
                    Image(systemName: "questionmark.circle")
                    Text("UnContacted")
                }
            MeView()
                .tabItem{
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
            
        }.environmentObject(prospects)
    }
}

struct Hot_Prospects_View_Previews: PreviewProvider {
    static var previews: some View {
        Hot_Prospects_View()
    }
}
