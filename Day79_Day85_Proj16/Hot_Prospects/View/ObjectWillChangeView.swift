//
//  ObjectWillChangeView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-03.
//

import SwiftUI

struct ObjectWillChangeView: View {
    @ObservedObject var updater = DelayedUpdater()
    var body: some View {
        Text("The value is \(updater.value)")
    }
}

struct ObjectWillChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectWillChangeView()
    }
}
