//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by T  on 2020-07-28.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habitList: Activities
    @State private var title = ""
    @State private var description = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 1){
                Spacer()
                Text("I would like to track ...")
                HStack{
                    TextField("Habit", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    
                }.padding()
      
                HStack{
                    TextField("More description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                } .padding()
                Spacer()
            }
                
            .navigationBarTitle("Add New Habit", displayMode: .inline)
            .background(Color.purple)
            .navigationBarItems(
                leading: Button("Cancel") {
                     self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                UserDefaults.standard.set(self.title, forKey: "title")
                self.habitList.activities.append(Activity(title: self.title, description: self.description, count: 0))
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(habitList: Activities())
    }
}
