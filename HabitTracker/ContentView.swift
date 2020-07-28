//
//  ContentView.swift
//  HabitTracker
//
//  Created by T  on 2020-07-26.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI


struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let count: Int
}


struct ContentView: View {
    var activities: [Activity] = []
    @State var addingActivity: Bool = false
    
    var body: some View {
        
        NavigationView() {
            List(activities) {activity in
                Text("Habit \(activity.id)")
            }.navigationBarTitle("HabitTracker")
                .navigationBarItems(leading: EditButton(), trailing: Button("+") {  self.addingActivity = true}
                    .sheet(isPresented: $addingActivity) {
                        AddActivityView()
                })
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
