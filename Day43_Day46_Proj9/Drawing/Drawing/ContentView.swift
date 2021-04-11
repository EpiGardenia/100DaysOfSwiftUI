//
//  ContentView.swift
//  Drawing
//
//  Created by T  on 2020-07-16.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x:rect.maxX, y:rect.maxY))
        path.addLine(to: CGPoint(x:rect.minX, y:rect.maxY))
        path.addLine(to: CGPoint(x:rect.midX, y:rect.minY))
        path.addLine(to: CGPoint(x:rect.maxX, y:rect.maxY))
        return path
    }
}


struct Arc: InsettableShape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

    return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}




struct ContentView: View {
    var body: some View {
        
//        Circle()
//            .strokeBorder(Color.blue, lineWidth:40)
//
        
        Arc(startAngle: .degrees(0), endAngle: .degrees(120), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 40)
            .frame(width:400, height:350)
  
//        Triangle()
//            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .butt, lineJoin: .round))
//            .frame(width:300, height:300)
        
//
//        Triangle()
//            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .square, lineJoin: .bevel))
//            .frame(width:100, height: 50)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
