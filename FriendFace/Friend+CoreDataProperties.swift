//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by T  on 2020-10-01.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var of: User?

}

extension Friend : Identifiable {

}
