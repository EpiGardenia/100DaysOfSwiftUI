//
//  ContentView.swift
//  Spirograph
//
//  Created by T  on 2020-07-20.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat
    
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * CGFloat(outerRadius) / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, to: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width/2
            y += rect.height/2
            
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
        }
        
        return path
    }
    
    
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        let a = a
        let b = b
        
        if a < b {
            return gcd(b, a)
        }
        
        let temp = a % b
        if temp == 0 {
            return b
        } else {
            return gcd(b, temp)
        }
    }
}


struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
            .frame(width: 300, height: 300)

            Spacer()
            
            Group {
                Text("Inner radius \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step:1)
                    .padding([.horizontal, .bottom])
                Text("outer radius \(Int(outerRadius))")
                       Slider(value: $outerRadius, in: 10...150, step:1)
                           .padding([.horizontal, .bottom])
                Text("Distance \(Int(distance))")
                       Slider(value: $distance, in: 1...150, step:1)
                           .padding([.horizontal, .bottom])
                Text("Amount \(amount, specifier: "%.2f")")
                       Slider(value: $amount)
                           .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
