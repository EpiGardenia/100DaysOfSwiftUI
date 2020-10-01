//
//  Tag+CoreDataProperties.swift
//  FriendFace
//
//  Created by T  on 2020-10-01.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tag: String?
    @NSManaged public var of: User?

}

extension Tag : Identifiable {

}
