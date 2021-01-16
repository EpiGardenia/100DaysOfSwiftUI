//
//  Day93_Scroll_selfTry.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-16.
//

/* Note: If I uncomment position, then there is no image at all, reason unknown*/

import SwiftUI

struct Day93_Scroll_selfTry: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
        GeometryReader{ fullView in
            ScrollView(.vertical) {
                    ForEach(0..<20) { index in
                     //   let preIndex = index % 7
                        GeometryReader{ geo in
                            Circle()
                                .fill(self.colors[index%7])
                                .frame(height: fullView.size.width/4, alignment: .center)
//                                .position(x: CGFloat(preIndex) * geo.size.width/7, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                .rotation3DEffect(
                                    .degrees(-Double(geo.frame(in: .global).minY - fullView.size.width/7)), axis: (x: 1, y: 0.7, z: 0.5))
                                .padding()
                            
                        }
                        .frame(width: fullView.size.width)
                    }.padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Day93_Scroll_selfTry_Previews: PreviewProvider {
    static var previews: some View {
        Day93_Scroll_selfTry()
    }
}
