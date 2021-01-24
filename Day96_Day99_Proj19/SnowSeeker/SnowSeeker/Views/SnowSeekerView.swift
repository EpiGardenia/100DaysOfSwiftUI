//
//  SnowSeekerView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import SwiftUI



struct SnowSeekerView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    let filterOptions = FilterOptions()
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(
                    destination: ResortView(resort: resort),
                    label: {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape( RoundedRectangle(cornerRadius: 5))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth:1 ))
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if self.favorites.contains(resort) {
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                        
                    })
            }.navigationBarTitle("Resorts")
            .navigationBarItems(trailing: FilterSortView())
            WelcomeView()
        }
        .environmentObject(favorites)
        .environmentObject(filterOptions)
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct SnowSeekerView_Previews: PreviewProvider {
    static var previews: some View {
        SnowSeekerView()
    }
}
