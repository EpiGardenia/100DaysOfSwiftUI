//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    var body: some View {
        VStack{
            Text("Elvation: \(resort.elevation)m")
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
