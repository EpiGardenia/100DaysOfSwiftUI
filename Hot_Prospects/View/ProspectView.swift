//
//  ProspectView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-05.
//

import SwiftUI
import CodeScanner

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject{
    @Published var people: [Prospect]
    init() {
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
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
    @State private var showingScanView = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(filterProspects) { prospect in
                    VStack(alignment: .leading){
                        Text(verbatim: prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .font(.body)
                    }.contextMenu(menuItems: {
                        Button(prospect.isContacted ? "Mark as UnContacted" : "Mark as Contacted") {
                            prospects.toggle(prospect)
                        }
                    })
                    
                }
            }
                .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    self.showingScanView = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
        }.sheet(isPresented: $showingScanView, content: {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan
        )})
        }
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.showingScanView = false
        switch result{
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else {return}
            let person = Prospect()
            person.name = details[0]
            person.email = details[1]
            
            self.prospects.people.append(person)
        case .failure(let error):
            print("Scanning failed due to \(error.localizedDescription)")
        }
    }
    
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filter: .none)
    }
}
