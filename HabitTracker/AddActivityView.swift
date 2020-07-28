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
    
    @State var title = ""
    @State var description = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 1.5){
                HStack{
                    Text("Title: ")
                        .font(.headline)
                    
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }.padding()
                Spacer()
                HStack{
                    Text("Description:")
                    //  TextEditor(text: $description)
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    
                } .padding()
                Spacer()
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .navigationBarTitle("Add New Habit")
            .navigationBarItems(trailing: Button("Save") {
                UserDefaults.standard.set(self.title, forKey: "title")
//                UserDefaults.setValue(self.title, forKey: "title")
//                UserDefaults.setValue(self.description, forKey: "description")
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
