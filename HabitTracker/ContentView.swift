//
//  ContentView.swift
//  HabitTracker
//
//  Created by T  on 2020-07-26.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI


struct Activity: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let count: Int
}

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet{
            
        }
        
    }
    
    init() {
        
        self.activities = []
        
    }
    
    
}



struct ContentView: View {
    //    var activities: [Activity] = []
    @State var addingActivity: Bool = false
    @ObservedObject var habits = Activities()
    var body: some View {
        NavigationView() {
            List(self.habits.activities) {activity in
                Text("Habit \(activity.title): \(activity.description) ")
            }.navigationBarTitle("HabitTracker")
                .navigationBarItems(leading: EditButton(), trailing: Button("+") {  self.addingActivity = true
                })
                .sheet(isPresented: $addingActivity) {
                    AddActivityView(habitList: self.habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
