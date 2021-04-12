//
//  ButtonView.swift
//  BucketList
//
//  Created by T  on 2020-11-03.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Text("Unlock Places")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
