//
//  TagView.swift
//  FriendFace
//
//  Created by T  on 2020-09-28.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct TagView: View {
    let show:[String]
    var body: some View {
        VStack{
            List(show, id: \.self) { tag in
                Text("#"+tag)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static let tags = ["labore", "sint"]
    static var previews: some View {
        TagView(show: tags)
    }
}
