//
//  ProspectView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-05.
//

import SwiftUI

class Prospect: Identifiable, Codable{
    let id = UUID()
    var name = "Anonymous"
    var email = ""
    var isContacted = false
}

class Prospects: ObservableObject{
    @Published var people: [Prospect]
    init() {
        self.people = []
    }
}

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectView: View {
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "EveryOne"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "UnContacted"
        }
    }
    
    var filterProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{ $0.isContacted }
        case .uncontacted:
            return prospects.people.filter{ !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(filterProspects) { prospect in
                    VStack(alignment: .leading){
                        Text(verbatim: prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .font(.body)
                    }
                    
                }
            }
                .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    let prospect = Prospect()
                    prospect.name = "Paul Hudson"
                    prospect.email = "paul@hackingwithswift.com"
                    self.prospects.people.append(prospect)
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
        }
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filter: .none)
    }
}
