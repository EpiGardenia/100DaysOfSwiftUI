//
//  Day95_Milestone6App.swift
//  Day95_Milestone6
//
//  Created by T  on 2021-01-19.
//

import SwiftUI

@main
struct Day95_Milestone6App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
