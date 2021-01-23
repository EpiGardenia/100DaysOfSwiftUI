//
//  ResortView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFacility: Facility?
    @State private var isFavorite = false
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0, content: {
                ZStack{
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Photo Credit: \(resort.imageCredit)")
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                        }
                    }
                }
                Group {
                    HStack{
                        if sizeClass == .compact {
                            //   Text("COMPACT CLASS")
                            Spacer()
                            VStack{
                                ResortDetailsView(resort: resort)
                            }
                            VStack{
                                SkiDetailsView(resort: resort)
                            }
                            Spacer()
                        } else
                        {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height:0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    
                    
                    // Using icons
                    HStack{
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                    
                    
                    //                    // A, B, and C
                    //                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
                    //                        .padding(.vertical)
                    
                    // A, B, C
                    //                    Text(resort.facilities
                    //                            .joined(separator: ", "))
                    //                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                
                Button(favorites.contains(resort) ? "Remove from Favourites" :  "Add to Favourites") {
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                    } else {
                        self.favorites.add(self.resort)
                    }
                }
                .padding()
                
            })
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        
    }
}


// Method 1:
extension String: Identifiable {
    public var id: String {self}
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
