//
//  AddressView.swift
//  CupCake
//
//  Created by T  on 2020-08-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI


struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
       // NavigationView {   <-- This will add one more layer in going back button.
            
            Form {
                Section{
                    TextField("Name", text: $order.name)
                    TextField("Street", text: $order.street)
                    TextField("Zip Code", text: $order.zipCode)
                    TextField("City", text: $order.city)
                }
                
                Section{
                    NavigationLink(destination: OrderFinishedView(order: self.order)) {
                        Text("Checkout")
                    }
                }
                .disabled(order.isInfoValid() == false)
            }
            .navigationBarTitle("Delivery Information")
      //  }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
