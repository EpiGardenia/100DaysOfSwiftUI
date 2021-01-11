//
//  Tag+CoreDataProperties.swift
//  FriendFace
//
//  Created by T  on 2020-10-03.
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
    @NSManaged public var of: NSSet?

    public var wrappedTag: String {
        tag ?? ""
    }
}

// MARK: Generated accessors for of
extension Tag {

    @objc(addOfObject:)
    @NSManaged public func addToOf(_ value: User)

    @objc(removeOfObject:)
    @NSManaged public func removeFromOf(_ value: User)

    @objc(addOf:)
    @NSManaged public func addToOf(_ values: NSSet)

    @objc(removeOf:)
    @NSManaged public func removeFromOf(_ values: NSSet)

}

extension Tag : Identifiable {

}
