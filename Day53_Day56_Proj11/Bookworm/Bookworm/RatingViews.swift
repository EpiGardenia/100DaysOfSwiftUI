//
//  ratingView.swift
//  Bookworm
//
//  Created by T  on 2020-08-24.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var onColor = Color.yellow
    var offColor = Color.gray


    var body: some View {
        
        HStack{
            ForEach(1..<6) { starIndex in
                Image(systemName: "star.fill")
                    .foregroundColor((starIndex > self.rating ) ? self.offColor: self.onColor)
                    .onTapGesture {
                        self.rating = starIndex
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
