//
//  ResortView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0, content: {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                Group {
                    HStack{
                        Spacer()
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    
                    // A, B, and C
                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
                        .padding(.vertical)
                    
                    // A, B, C
                    //                    Text(resort.facilities
                    //                            .joined(separator: ", "))
                    //                        .padding(.vertical)
                }
                .padding(.horizontal)
            })
        }.navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
