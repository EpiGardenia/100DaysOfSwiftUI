//
//  ContentView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-01.
//

import SwiftUI

struct ContentView: View {
    let user = User()
    var body: some View {
        Text("Content View")
            .padding()
        ViewA()
            .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
