//
//  AddressView.swift
//  CupCake
//
//  Created by T  on 2020-08-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

class Address: ObservableObject {
    @Published var name: String = ""
    @Published var street: String = ""
    @Published var zipCode = ""
    @Published var city = ""
}


struct AddressView: View {
    
    @ObservedObject var address = Address()
    
    var body: some View {
        NavigationView {
            
            Form {
                Section{
                    TextField("Name", text: $address.name)
                    TextField("Street", text: $address.street)
                    TextField("Zip Code", text: $address.zipCode)
                    TextField("City", text: $address.city)
                }

                Section{
                    NavigationLink(destination: OrderFinishedView()) {
                        Text("Checkout")
                    }
                }
            }
        }
    }
    
    
    func checkout()  {
        // Save values in default.
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
