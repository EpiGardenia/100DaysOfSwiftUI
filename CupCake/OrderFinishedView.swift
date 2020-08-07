//
//  OrderFinishedView.swift
//  CupCake
//
//  Created by T  on 2020-08-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct OrderFinishedView: View {
    @ObservedObject var order: Order
    @State private var cfmMessage = "" {
        didSet{
            showingCfm = true
        }
    }
    @State private var showingCfm = false
    
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(){
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is \(self.order.calculateCost()) kr")
                        .padding()
                    Spacer()
                    Button("Place Order") {
                        guard let encoded = try? JSONEncoder().encode(self.order)
                            else {
                                print("Failed to encode order")
                                return
                        }
                        
                        
                        let url = URL(string: "https://reqres.in/api/cupcakes")!
                        var request = URLRequest(url: url)
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.httpMethod = "POST"
                        request.httpBody = encoded
                        URLSession.shared.dataTask(with: request) { data, response, error in
                        
                            
                            guard let data = data else {
                                self.cfmMessage = "No data in response: \(error?.localizedDescription ?? "Unknown Error" )."
                                return
                            }
                            
                            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                                self.cfmMessage = "Your \(decodedOrder.quantity) \(Order.types[decodedOrder.type]) cakes will be sent to \(decodedOrder.name) in 30 minutes"
                            } else {
                                self.cfmMessage = "Invalid response from server"
                            }
                            self.showingCfm = true
                        }.resume()
                    }
                }
            }
        }.navigationBarTitle("Check out", displayMode: .inline)
            .alert(isPresented: $showingCfm) {
                Alert(title: Text("Thank you!"), message: Text(cfmMessage), dismissButton: .default(Text("OK")) )
        }
    }
}

struct OrderFinishedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderFinishedView(order: Order())
    }
}
