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
            Group {
                Text("Country")
                    .modifier(CategoryModifier())
                VStack(alignment: .leading){
                    CategoryView(category: .country)
                }
            }
            Divider()
            Group{
                Text("Price")
                    .modifier(CategoryModifier())
                HStack{
                    CategoryView(category: .price)
                }
            }
            Divider()
            Group {
                Text("Size")
                    .modifier(CategoryModifier())
                HStack{
                    CategoryView(category: .size)
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


struct FilterSortIcons: View {
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
            .font(.title2)
            .padding()
            .foregroundColor(.blue)
            .background(Color.white)
            .clipShape(Capsule())
    }
}

struct CategoryModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding()
    }
}


struct CategoryView: View {
    let category: FilterCategory
    @EnvironmentObject var filterOptions: FilterOptions
    
    var body: some View {
        let categoriedFilterOptions = filterOptions.filterOptions.filter{$0.category == category}
        ForEach(categoriedFilterOptions, id:\.self) { filterOption in
            HStack{
                Button(action: {filterOptions.toggle(filterOption)}) {
                    Image(systemName: filterOption.isChecked ? "square.fill" : "square")
                }
                Text(filterOption.title)
            }
        }
    }
}


struct FilterSortView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSortIcons()
    }
}
