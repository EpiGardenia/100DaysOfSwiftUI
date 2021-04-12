//
//  Day96_groupsLayoutView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-20.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Totoro")
            Text("Country: Japan")
            Text("Pet: Chu, Chibi, Mei, Satsuki")
        }
    }
}

struct Day96_groupsLayoutView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct Day96_groupsLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        Day96_groupsLayoutView()
    }
}
