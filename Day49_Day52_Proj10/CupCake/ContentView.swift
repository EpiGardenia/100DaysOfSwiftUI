//
//  ContentView.swift
//  CupCake
//
//  Created by T  on 2020-08-01.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI




struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView() {
            Form {
                Section {
                    Picker("Type of Cake", selection: $order.type) {
                        ForEach(0 ..< Order.types.count, id:\.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 2...20) {
                        Text("Number of Cakes: \(order.quantity)")
                    }
                }
                
                Section{
                    Toggle(isOn: $order.specialRequestEnabled) {
                         Text("Any Special Request?")
                    }
                    
                    if self.order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Extra Frosting?")
                        }
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add Sprinkles?")
                        }
                    }
                }
                
                Section{
                    NavigationLink(destination: AddressView(order: order)) {
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
