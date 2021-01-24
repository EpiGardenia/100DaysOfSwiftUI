//
//  FilterOption.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-24.
//

import Foundation

enum SortMethod {
    case name, country
}

class FilterOption: ObservableObject, Codable, Hashable{
    static func == (lhs: FilterOption, rhs: FilterOption) -> Bool {
        return lhs.title == rhs.title
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    var category = FilterCategory.country
    var title = ""
    var isChecked = false
    init(category: FilterCategory, title: String, isChecked: Bool) {
        self.category = category
        self.title = title
        self.isChecked = isChecked
    }
}

class FilterOptions: ObservableObject{
    @Published var sortMethod: SortMethod = .name
    private var countries: Array<String> = []
    private var pricesInt: Array<Int> = []
    private var sizesInt: Array<Int> = []
    private var allResorts: [Resort] = []
    private let fileURL = FileManager.getDocURL(of: "filterOptions.json")
    @Published var filterOptions: [FilterOption] = []
    init() {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            self.filterOptions = Bundle.main.decode(fileURL)
        } else {
            self.allResorts = Bundle.main.decode("resorts.json")
            self.filterOptions = getLatestList()
        }
    }
    
    func getLatestList() -> [FilterOption] {
        countries = Array(Set(self.allResorts.map{$0.country})).sorted()
        var list = countries.map{FilterOption(category: .country, title: $0, isChecked: false)}
        pricesInt =  Array(Set(self.allResorts.map{$0.price})).sorted()
        list += pricesInt.map{FilterOption(category: .price, title: priceString(fromInt: $0), isChecked: false)}
        sizesInt = Array(Set(self.allResorts.map{$0.size})).sorted()
        list += sizesInt.map{FilterOption(category: .size, title: sizeString(fromInt: $0), isChecked: false)}
        print(list)
        return list
    }
    
    func toggle(_ filterOption: FilterOption) {
        objectWillChange.send()
        filterOption.isChecked.toggle()
    }
    
    func sort(_ list: [Resort]) -> [Resort] {
        switch self.sortMethod {
        case .name:
            return list.sorted{$0.name < $1.name}
        case .country:
            return list.sorted{$0.country < $1.country}
        }
    }
    
    func getFilteredResorts() -> [Resort] {
        self.allResorts = Bundle.main.decode("resorts.json")
        let validCountries = filterOptions.filter{$0.category == .country}.filter{$0.isChecked}.map{$0.title}
        let validPrices = filterOptions.filter{$0.category == .price}.filter{$0.isChecked}.map{$0.title}
        let validSizes = filterOptions.filter{$0.category == .size}.filter{$0.isChecked}.map{$0.title}
        var validResorts = validCountries == [] ? allResorts : allResorts.filter{validCountries.contains($0.country)}
        validResorts = validPrices == [] ? validResorts : validResorts.filter{validPrices.contains(priceString(fromInt: $0.price))}
        validResorts = validSizes == [] ? validResorts : validResorts.filter{validSizes.contains(sizeString(fromInt: $0.size))}
        return sort(validResorts)
    }
    
    func save() {
        Bundle.main.encode(data: self.filterOptions, url: self.fileURL)
    }
    
    func reset() {
        self.filterOptions = getLatestList()
    }
    
    func sizeString(fromInt size:Int) -> String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    func priceString(fromInt price: Int) -> String {
       return String(repeating: "$", count: price)
    }
}

enum FilterCategory: Codable {
    enum Key: CodingKey{
        case rawValue
    }
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .country
        case 1:
            self = .size
        case 2:
            self = .price
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .country:
            try container.encode(0, forKey: .rawValue)
        case .size:
            try container.encode(1, forKey: .rawValue)
        case .price:
            try container.encode(2, forKey: .rawValue)
        }
    }
    
    case country, size, price
}
