//
//  Day93_ScrollWithGeometryView.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-16.
//

import SwiftUI

struct Day93_ScrollWithGeometryView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

        var body: some View {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(width: fullView.size.width)
                                .background(self.colors[index % 7])
                                .rotation3DEffect(
                                    .degrees(Double(geo.frame(in: .global).midY)),
                                    axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                    )
                                //                                .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY) / 5), axis: (x: 0, y: 1, z: 0))
//                                .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
                            //print(geo.frame(in: .global))
                            
                            
                        }
                        .frame(height: 40)
                    }
                }
            }
        }
}

struct Day93_ScrollWithGeometryView_Previews: PreviewProvider {
    static var previews: some View {
        Day93_ScrollWithGeometryView()
    }
}
