//
//  SnowSeekerView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import SwiftUI

struct SnowSeekerView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
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
                    })
            }.navigationBarTitle("Resorts")
            WelcomeView()
        }
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
