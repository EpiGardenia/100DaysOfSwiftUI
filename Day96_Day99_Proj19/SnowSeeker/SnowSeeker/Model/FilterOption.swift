//
//  FilterOption.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-24.
//

import Foundation

class FilterOption: ObservableObject, Codable{
    static func == (lhs: FilterOption, rhs: FilterOption) -> Bool {
        return lhs.title == rhs.title
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
    private var countries: Set<String> = []
    private var allResorts: [Resort] = []
    private let fileURL = FileManager.getDocURL(of: "filterOptions.json")
    @Published var filterOptions: [FilterOption] = []
    init() {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            self.filterOptions = Bundle.main.decode(fileURL)
        } else {
            self.allResorts = Bundle.main.decode("resorts.json")
            self.filterOptions =
                getLatestList()
        }
    }
    
    func getLatestList() -> [FilterOption] {
        countries = Set(self.allResorts.map{$0.country})
        let list = countries.map{FilterOption(category: .country, title: $0, isChecked: false)}
        print(list)
        return list
    }
    
    func toggle(_ filterOption: FilterOption) {
        filterOption.isChecked.toggle()
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
