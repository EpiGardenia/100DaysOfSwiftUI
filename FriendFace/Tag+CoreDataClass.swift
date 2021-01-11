//
//  Tag+CoreDataClass.swift
//  FriendFace
//
//  Created by T  on 2020-10-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case tag
    }
    enum OfCondingKeys: String, CodingKey{
        case of
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tag = try container.decode(String.self, forKey: .tag)
        of = try container.decode(User.self, forKey: OfCondingKeys.self)
    }

    public func encode(to encoder: Encoder) throws {
        
    }
}
