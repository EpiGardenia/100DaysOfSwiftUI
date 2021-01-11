//
//  AddView.swift
//  iExpense
//
//  Created by T  on 2020-07-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Business", "Personal"]
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                
            }.navigationBarTitle("Add new expense")
                .navigationBarItems(trailing:
                    Button("Save") {
                        if let numericAmount = Int(self.amount) {
                            self.expenses.eobj.append(ExpenseItem(name: self.name, type: self.type, amount: numericAmount))
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showingAlert  = true
                        }
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Warning") , message: Text("The amount should be number"), dismissButton: .default(Text("I will change it")))
            }
            
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
