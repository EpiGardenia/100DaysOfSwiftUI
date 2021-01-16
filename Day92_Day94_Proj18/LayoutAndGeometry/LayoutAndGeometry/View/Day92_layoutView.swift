//
//  Day92_layout.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-15.
//

import SwiftUI

struct Day92_layoutView: View {
    var body: some View {
        /* 1. Text -> padding: I need x,y
           2. padding -> background: I need x, y and 20 each side
           3. Background->ContentView: Then I need x,y and 20 each side.
        */
        Text("Hello, World!")
            .padding(20)
            .background(Color.red)
        
        /* 1. Text -> background: I need x,y
           2. background -> padding: I need x, y
           3. padding->ContentView: Then I need x,y and 20 each side.
        */
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(Color.red)
            .padding(20)
        
    }
}

struct Day92_layout_Previews: PreviewProvider {
    static var previews: some View {
        Day92_layoutView()
    }
}
