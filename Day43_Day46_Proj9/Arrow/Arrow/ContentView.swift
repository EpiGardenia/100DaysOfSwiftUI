//
//  ContentView.swift
//  Arrow
//
//  Created by T  on 2020-07-24.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct Arrow: InsettableShape {
    let thickness: CGFloat
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let triangleHeight = rect.height * 0.3
        let halfTriangleWidth = thickness * 1.75 / 2
        let triangInset: CGFloat = insetAmount/100 * triangleHeight/2
        let insetRatio: CGFloat = insetAmount/100 * thickness/2
        var path1 = Path()
        path1.move(to: CGPoint(x: rect.midX , y: rect.minY + triangInset))
        path1.addLine(to: CGPoint(x: rect.midX - halfTriangleWidth + triangInset , y: triangleHeight - triangInset * 0.3) )
        path1.addLine(to: CGPoint(x: rect.midX + halfTriangleWidth - triangInset, y: triangleHeight - triangInset * 0.3))
        path1.addLine(to: CGPoint(x: rect.midX, y: rect.minY + insetRatio))
        path1.addRect(CGRect(x: (rect.width - thickness)/2 + insetRatio, y: triangleHeight + insetRatio, width: thickness - insetRatio * 2, height: rect.height - triangleHeight - insetRatio * 2))
        return path1
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var thickness: CGFloat = 1
    var steps = 100
    
    var body: some View {
        ZStack{
            ForEach(0..<steps) { value in
               // Arrow(thickness: self.thickness)
                Rectangle()
                    .inset(by: CGFloat(value))
                    //   .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient:
                        Gradient(colors: [self.color(for: value, brightness: 2),
                                          self.color(for: value, brightness: 1)]), startPoint: .top, endPoint: .bottom),
                                  lineWidth: 1.5)
                
                
            }
        }
    .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var hueValue = Double(value) / Double(self.steps) + self.amount
        
        if hueValue > 1 {
            hueValue -= 1
        }

        return Color(hue: hueValue, saturation: 1, brightness: brightness)
    }
    
}


struct ContentView: View {
    @State private var thickness: CGFloat = 0.0
    @State private var colorCycle = 0.0
    private var width: CGFloat = 150
    private var height: CGFloat = 150

    var body: some View {
        VStack {
            Spacer()
            Arrow(thickness: thickness)
                .frame(width: width, height: height, alignment: .center)

            Spacer()
            Text("Arrow Thickness")
            Slider(value: $thickness, in: width/6...width/2)
            .padding()

            Spacer()
            ColorCyclingRectangle(amount: colorCycle, thickness: thickness)
                .frame(width: 150, height: 150)
            
            Spacer()
            Slider(value: $colorCycle)
            
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
