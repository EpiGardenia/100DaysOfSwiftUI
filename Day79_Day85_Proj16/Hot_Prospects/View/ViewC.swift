//
//  ViewC.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-01.
//

import SwiftUI

struct ViewC: View {
    @EnvironmentObject var user: User
    var body: some View {
        Text("ViewC: " + user.name)
    }
}

struct ViewC_Previews: PreviewProvider {
    static var previews: some View {
        ViewC()
    }
}
