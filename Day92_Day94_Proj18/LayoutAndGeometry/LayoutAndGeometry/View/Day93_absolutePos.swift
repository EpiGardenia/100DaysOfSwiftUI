//
//  Day93_absolutePos.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-16.
//

import SwiftUI

struct Day93_absolutePos: View {
    var body: some View {
        Group{
            VStack{
                Text("Hello, World 1!")
                    .position(x:100, y:100)
                    .background(Color.green)
                Text("Hello, World 2!")
                    .background(Color.green)
                    .position(x:100, y:100)
            }
        }
        Group {
      //      VStack{
                Text("offset-color!")
                    .offset(x:100, y:100)
                    .background(Color.orange)
                Text("color-offset!")
                    .background(Color.orange)
                    .offset(x:100, y:100)

        //    }
        }
        
    }
}

struct Day93_absolutePos_Previews: PreviewProvider {
    static var previews: some View {
        Day93_absolutePos()
    }
}
