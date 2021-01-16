//
//  Day92_customAlignGuidanceView.swift
//  LayoutAndGeometry
//
//  Created by T  on 2021-01-15.
//

import SwiftUI

extension VerticalAlignment{
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName =
        VerticalAlignment(MidAccountAndName.self)
}
struct Day92_customAlignGuidanceView: View {
    var body: some View {
        
        HStack(alignment: .midAccountAndName){
            VStack{
                Text("Extra Line1")
                Text("@twoStraws")
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Extra Line2")
            }
            VStack{
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                    .font(.largeTitle)
            }
        }
        
        
    }
}

struct Day92_customAlignGuidanceView_Previews: PreviewProvider {
    static var previews: some View {
        Day92_customAlignGuidanceView()
    }
}
