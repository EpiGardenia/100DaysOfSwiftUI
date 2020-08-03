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
                    Picker("Type of Cake", selection: $order.type) {
                        ForEach(0 ..< Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 1...20) {
                        Text("Number of Cakes: \(order.quantity)")
                    }
                }
                
                Section{
                    Toggle(isOn: $order.specialRequestEnabled) {
                         Text("Any Special Request?")
                    }
                }
                
                Section{
                    NavigationLink(destination: AddressView()) {
                        Text("Delivery Details")
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
