//
//  ContactView.swift
//  IRemember
//
//  Created by T  on 2020-12-26.
//

import SwiftUI

struct ContactView: View {
    let name: String
    let photo: Image
    
    var body: some View {
        VStack {
        photo
            .resizable()
            .scaledToFit()
        Text(name)
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(name: "Salad", photo: Image(systemName: "applelogo"))
    }
}
