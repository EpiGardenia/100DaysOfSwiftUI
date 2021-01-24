//
//  FilterSortView.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-24.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var filterOptions: FilterOptions
    var body: some View {
        VStack{
            List(filterOptions.filterOptions, id:\.self) { filterOption in
                HStack{
                    Button(action: {filterOptions.toggle(filterOption)}) {
                        Image(systemName: filterOption.isChecked ? "square.fill" : "square")
                    }
                    Text(filterOption.title)
                }
            }
            
            Spacer()
            Button("Filter") {
                presentationMode.wrappedValue.dismiss()
            }.modifier(ButtonModifier())
        }
    }
}



struct FilterSortView: View {
    @State private var showingFilterView = false
    var body: some View {
        HStack{
            Button("Sort") {
                
            }.modifier(ButtonModifier())
            Button("Filter") {
                showingFilterView = true
            }.modifier(ButtonModifier())
        }.sheet(isPresented: $showingFilterView, content: {
            FilterView()
        })
    }
}


struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .foregroundColor(.blue)
            .background(Color.white)
            .clipShape(Capsule())
    }
}

struct FilterSortView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSortView()
    }
}
