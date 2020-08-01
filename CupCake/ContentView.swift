//
//  ContentView.swift
//  CupCake
//
//  Created by T  on 2020-08-01.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI


class Order: ObservableObject {
    static let types = ["Vallina", "Chocklate", "Pineapple"]
    @Published var type = 0
    @Published var quantity = 0
    @Published var specialRequestEnabled = false
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}


struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView() {
            Form {
                Section {
                    Picker("Cake Flavour", selection: $order.type) {
                        ForEach(0 ..< Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                }
                
                Section{
                    Stepper(value: $order.quantity, in: 1...20) {
                        Text("Cake Quantity : \(order.quantity)")
                    }
                }
                
                
            }.navigationBarTitle("Cupcake")
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
