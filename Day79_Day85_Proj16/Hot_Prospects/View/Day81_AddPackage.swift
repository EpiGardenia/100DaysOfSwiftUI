//
//  Day81_AddPackage.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-04.
//
import SamplePackage
import SwiftUI

struct Day81_AddPackage: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    var body: some View {
        Text(results)
    }
}

struct Day81_AddPackage_Previews: PreviewProvider {
    static var previews: some View {
        Day81_AddPackage()
    }
}
