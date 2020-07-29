//
//  ContentView.swift
//  HabitTracker
//
//  Created by T  on 2020-07-26.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI


class Activity: Identifiable, ObservableObject {
    let id = UUID()
    let title: String
    let description: String
    @Published var count: Int
    
    
    init() {
        title = ""
        description = ""
        count = 0
    }
    
    init(title: String, description: String, count: Int) {
        self.title = title
        self.description = description
        self.count = count
    }
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
    @State var addingActivity: Bool = false
    @ObservedObject var habits = Activities()
    var body: some View {
        NavigationView() {
            List(self.habits.activities) {activity in
                NavigationLink(destination: HabitView(habit: activity)) {
                    Text("Habit \(activity.title): \(activity.description) ")
                }
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
