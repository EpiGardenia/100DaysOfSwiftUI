//
//  ContentView.swift
//  Animations
//
//  Created by T  on 2020-04-30.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
        .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topTrailing),
            identity: CornerRotateModifier(amount: 0, anchor: .topTrailing))
    }
}

struct ContentView: View {
    @State private var isShowingNose = true
    var body: some View {
        VStack{
            Button("Grisens Näsa") {
                withAnimation{
                    self.isShowingNose.toggle()
                }
            }
            if isShowingNose {
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}