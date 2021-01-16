//
//  Day92_Alignment.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-15.
//

import SwiftUI


struct Day92_Alignment: View {
    var body: some View {

        
        /* Example 5*/
        VStack(alignment: .leading, content: {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading, computeValue: { dimension in
                        CGFloat(position) * -10
                    })
            
            }})
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
        
        /* Example 4*/
        VStack(alignment: .leading) {
            Text("Hello Wolrd!")
                .alignmentGuide(.leading, computeValue: { dimension in
                    dimension[.trailing]
                })
            Text("This is a longer line of text")
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
        
        /* Example 3*/
        HStack(alignment: .lastTextBaseline){
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
        
        /* Example 2*/
        HStack(alignment: .bottom){
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
        /* Example 1 */
        Text("Live long and prosper")
            .frame(width: 300, height: 300, alignment: .topLeading)
    }
}

struct Day92_Alignment_Previews: PreviewProvider {
    static var previews: some View {
        Day92_Alignment()
    }
}
