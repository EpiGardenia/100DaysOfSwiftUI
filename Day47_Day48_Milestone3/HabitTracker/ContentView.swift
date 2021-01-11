//
//  ContentView.swift
//  HabitTracker
//
//  Created by T  on 2020-07-26.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

class Activity: Identifiable, ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case count
    }
    let id = UUID()
    let title: String
    let description: String
    @Published var count: Int
    
    init(title: String, description: String, count: Int) {
        self.title = title
        self.description = description
        self.count = count
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        title = ""
        description = ""
    }
}

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: data) {
                self.activities = decoded
            }
        }
        self.activities = []
    }
}



struct ContentView: View {
    @State var addingActivity: Bool = false
    @ObservedObject var habits = Activities()
    var body: some View {
        NavigationView() {
                List {
                    ForEach(self.habits.activities)  {activity in
                        NavigationLink(destination: HabitView(habit: activity)) {
                            Text("\(activity.title): \(activity.description) ")
                        }
                        //    .listRowBackground(Color.yellow)
                        //   .padding()
                    }.onDelete(perform: deleteRow)
                }
                .navigationBarTitle("HabitTracker")
                    //    .colorMultiply(Color.blue)  => this will cause list under title
                    
                    .navigationBarItems(leading: EditButton(), trailing: Button("+") {  self.addingActivity = true
                    })
                    .sheet(isPresented: $addingActivity) {
                        AddActivityView(habitList: self.habits)
            }
        }
    }
    
    func deleteRow(at row: IndexSet) {
        self.habits.activities.remove(atOffsets: row)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
