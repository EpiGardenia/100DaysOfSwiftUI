//
//  ImageInterpolationView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-03.
//

import SwiftUI

struct ImageInterpolationView: View {
    

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)

    }
}

struct ImageInterpolationView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolationView()
    }
}
