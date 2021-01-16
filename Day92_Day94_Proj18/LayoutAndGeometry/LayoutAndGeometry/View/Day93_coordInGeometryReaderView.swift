//
//  Day93_coordInGeometryReaderView.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-16.
//

import SwiftUI
/************************Example 1*****************************/
struct exampleOneView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(Color.red)
            }
            
            Text("More text")
                .background(Color.blue)
        }
    }
}
/************************Example 2*****************************/
struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Circle() // from the edge of the screen
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                Circle() // from edge of OuterView (all color area)
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .position(x: geo.frame(in: .named("Custom")).midX, y: geo.frame(in: .named("Custom")).midY)
                Circle() // from the edge of geometry (organge area)
                    .fill(Color.purple)
                    .frame(width: 10, height: 10)
                    .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
    
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
       
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
          
                    }
            }
            .background(Color.orange)
            Text("Right")
            
        }
    }
}

struct exampleTwoView: View {
    var body: some View {
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

/************************Main View*****************************/
struct Day93_coordInGeometryReaderView: View {
    var body: some View {
       // exampleOneView()
        exampleTwoView()
    }
}

struct Day93_coordInGeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        Day93_coordInGeometryReaderView()
    }
}
