//
//  Day93_Scroll_coverFlow.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-16.
//

import SwiftUI

struct Day93_Scroll_coverFlow: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

       var body: some View {
           GeometryReader { fullView in
               ScrollView(.horizontal, showsIndicators: false) {
                   HStack {
                       ForEach(0..<50) { index in
                           GeometryReader { geo in
                               Rectangle()
                                   .fill(self.colors[index % 7])
                                   .frame(height: 150)
                                   .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                           }
                           .frame(width: 150)
                       }
                   }
                   .padding(.horizontal, (fullView.size.width - 150) / 2)
               }
           }
           .edgesIgnoringSafeArea(.all)
       }
}

struct Day93_Scroll_coverFlow_Previews: PreviewProvider {
    static var previews: some View {
        Day93_Scroll_coverFlow()
    }
}
