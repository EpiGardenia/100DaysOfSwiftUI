//
//  ContentView.swift
//  iExpense
//
//  Created by T  on 2020-07-01.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
 //  @Published var eobj = [ExpenseItem]()
    
    @Published var eobj: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(eobj) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.eobj = decoded
                return
            }
        }

        self.eobj = []
    }
}

struct ContentView: View {
   @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
        NavigationView{
            List {
                ForEach(expenses.eobj) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(item.name)")
                            Text("\(item.type)")
                        }
                        Spacer()
                        if item.amount < 10 {
                            Text("$\(item.amount)").foregroundColor(Color.blue)
                        } else if item.amount < 100{
                            Text("$\(item.amount)").foregroundColor(Color.orange)
                        } else {
                            Text("$\(item.amount)").foregroundColor(Color.red)
                        }
                    }
                }.onDelete(perform: removeRow)
                
            }.navigationBarTitle("iExpense")
                .navigationBarItems(leading:  EditButton(), trailing: Button("+") {
                    self.showingAddExpense = true
                })
                
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeRow(at offset: IndexSet) {
        expenses.eobj.remove(atOffsets: offset)
    }
    
    func addItems(newItem: ExpenseItem) {
        expenses.eobj.append(newItem)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
