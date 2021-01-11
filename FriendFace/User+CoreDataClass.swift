//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by T  on 2020-10-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey{
        case id, isActive, name, age, company, email, address, abuout, registered, tag, friend
    }
    enum TagCodingKeys: String, CodingKey{
        case tag
    }
    enum FriendCodingKeys: String, CodingKey{
        case id, name
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        tag = try container.decode(Tag.self, forKey: TagCodingKeys.self)
        indivTag = try tag.decode(String.self, forKey: .tag)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
