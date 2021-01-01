//
//  ViewA.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-01.
//

import SwiftUI

struct ViewA: View {
    @EnvironmentObject var user: User
    var body: some View {
        TextField("ViewA: Name", text: $user.name)
        ViewB()
    }
}

struct ViewA_Previews: PreviewProvider {
    static var previews: some View {
        ViewA()
    }
}
