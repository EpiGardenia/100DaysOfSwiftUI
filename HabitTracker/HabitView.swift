//
//  HabitView.swift
//  HabitTracker
//
//  Created by T  on 2020-07-29.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct HabitView: View {
   // var habit: Activity
    @ObservedObject var habit: Activity
    
//    
//    init(habit: Activity) {
//        
//    }
    
    var body: some View {
        VStack{
            Spacer()
            Text(habit.title)
            Spacer()
            Text(habit.description)
            Spacer()
            Text("For " + String(habit.count) + " Times")
            Spacer()
            Button("I have done today too!") {
                self.habit.count += 1
            }
            Spacer()
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var habitDetail = Activities().activities[0]
    static var previews: some View {
        HabitView(habit: habitDetail)
    }
}
