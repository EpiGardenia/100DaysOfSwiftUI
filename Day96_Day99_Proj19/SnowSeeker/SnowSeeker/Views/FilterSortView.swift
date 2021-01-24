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
        let countryFilterOptions = filterOptions.filterOptions.filter{$0.category == .country}
        let priceFilterOptions = filterOptions.filterOptions.filter{$0.category == .price}
        let sizeFilterOptions = filterOptions.filterOptions.filter{$0.category == .size}
        VStack{
            Group {
                Text("Country")
                    .font(.title2)
                    .padding()
                VStack(alignment: .leading){
                    ForEach(countryFilterOptions, id:\.self) { filterOption in
                        HStack{
                            Button(action: {filterOptions.toggle(filterOption)}) {
                                Image(systemName: filterOption.isChecked ? "square.fill" : "square")
                            }
                            Text(filterOption.title)
                        }
                    }
                }
            }
            Divider()
            Group{
                Text("Price")
                    .font(.title2)
                    .padding()
                HStack{
                    ForEach(priceFilterOptions, id:\.self) { filterOption in
                        HStack{
                            Button(action: {filterOptions.toggle(filterOption)}) {
                                Image(systemName: filterOption.isChecked ? "square.fill" : "square")
                            }
                            Text(filterOption.title)
                        }
                    }
                }
            }
            Divider()
            Group {
                Text("Size")
                    .font(.title2)
                    .padding()
                HStack{
                    ForEach(sizeFilterOptions, id:\.self) { filterOption in
                        HStack{
                            Button(action: {filterOptions.toggle(filterOption)}) {
                                Image(systemName: filterOption.isChecked ? "square.fill" : "square")
                            }
                            Text(filterOption.title)
                        }
                    }
                }
            }
            Divider()
            Spacer()
            HStack{
                Button("Filter") {
                    filterOptions.save()
                    presentationMode.wrappedValue.dismiss()
                }.modifier(ButtonModifier())
                Button("Reset") {
                    filterOptions.reset()
                    presentationMode.wrappedValue.dismiss()
                }.modifier(ButtonModifier())
            }.padding()
        }
    }
}



struct FilterSortView: View {
    @EnvironmentObject var filterOptions: FilterOptions
    @State private var showingFilterView = false
    @State private var showingSortView = false
    var body: some View {
        HStack{
            Button("Sort") {
                showingSortView = true
            }.modifier(ButtonModifier())
            Button("Filter") {
                showingFilterView = true
            }.modifier(ButtonModifier())
        }.sheet(isPresented: $showingFilterView, content: {
            FilterView()
        })
        .actionSheet(isPresented: $showingSortView, content: {
            ActionSheet(title: Text("Sort"), buttons: [
                            .default(Text("Name")) {filterOptions.sortMethod = .name},
                            .default(Text("Country")) {filterOptions.sortMethod = .country},
                            .cancel()])
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
