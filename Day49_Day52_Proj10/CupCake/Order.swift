//
//  Order.swift
//  CupCake
//
//  Created by T  on 2020-08-06.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
    enum codingKey: CodingKey {
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, zipCode, city
    }
    static let types = ["Vallina", "Chocklate", "Pineapple"]
    @Published var type = 0
    @Published var quantity = 5
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    @Published var name: String = ""
    @Published var street: String = ""
    @Published var zipCode = ""
    @Published var city = ""
    
    func isEmptyOrSpace(string: String) -> Bool {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString.isEmpty
    }
    
    func isInfoValid() -> Bool {
        return (!isEmptyOrSpace(string: name) && !isEmptyOrSpace(string: street)
            && !isEmptyOrSpace(string: zipCode) && !isEmptyOrSpace(string: city))
    }
    
    func calculateCost() -> Int{
        var   cost =  type + 1
        if extraFrosting {
            cost += 1
        }
        if addSprinkles {
            cost += 1
        }
        
        cost *= quantity
        return cost
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let deContainer = try decoder.container(keyedBy: codingKey.self)
        type = try deContainer.decode(Int.self, forKey: .type)
        quantity =  try deContainer.decode(Int.self, forKey: .quantity)
        specialRequestEnabled =  try deContainer.decode(Bool.self, forKey: .specialRequestEnabled)
        extraFrosting = try deContainer.decode(Bool.self, forKey: .extraFrosting )
        addSprinkles = try deContainer.decode(Bool.self, forKey: .addSprinkles )
        name = try deContainer.decode(String.self, forKey: .name)
        street = try deContainer.decode(String.self, forKey: .streetAddress )
        zipCode = try deContainer.decode(String.self, forKey: .zipCode )
        city = try deContainer.decode(String.self, forKey: .city )
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: codingKey.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(extraFrosting, forKey: .extraFrosting )
        try container.encode(addSprinkles, forKey: .addSprinkles )
        try container.encode(name, forKey: .name)
        try container.encode(street, forKey: .streetAddress )
        try container.encode(zipCode, forKey: .zipCode )
        try container.encode(city, forKey: .city )
    }
    
    
    
    
}
