//
//  ResortView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: String?
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0, content: {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
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
                        ForEach(resort.facilities) { facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }.padding(.vertical)
                    
                    
                    //                    // A, B, and C
                    //                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
                    //                        .padding(.vertical)
                    
                    // A, B, C
                    //                    Text(resort.facilities
                    //                            .joined(separator: ", "))
                    //                        .padding(.vertical)
                }
                .padding(.horizontal)
            })
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            Facility.alert(for: facility)
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
