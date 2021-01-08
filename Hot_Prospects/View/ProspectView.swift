//
//  ProspectView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-05.
//

import SwiftUI
import CodeScanner

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
    
    var showingIcon: Bool {
        return filter == .none
    }
    
    
    @State private var showingScanView = false
    let defaults = UserDefaults.standard
    @State private var allowNotification = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(filterProspects) { prospect in
                    HStack{
                        VStack(alignment: .leading){
                            Text(verbatim: prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .font(.body)
                        }
                        Spacer()
                        // Challenge1
                        if showingIcon {
                            prospect.isContacted ? Image(systemName: "person.crop.circle.badge.checkmark"): Image(systemName:"person.crop.circle")
                        }
                    }.contextMenu(menuItems: {
                        Button(prospect.isContacted ? "Mark as UnContacted" : "Mark as Contacted") {
                            prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.setReminder(prospect)
                            }
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
    
    func setReminder(_ prospect: Prospect) {
        // Check if allow notification
        if allowNotification == false {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.badge, .sound, .alert], completionHandler: { success, error in
                    if success {
                        allowNotification = true
                    } else if error != nil {
                        print(error!.localizedDescription)
                        return
                    }})
        }
        
        // Set reminder
        let content = UNMutableNotificationContent()
        content.title = "Contact \(prospect.name)"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
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
            self.prospects.add(person)
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
