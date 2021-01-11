//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by T  on 2020-10-03.
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
    @NSManaged public var of: NSSet?
    
    public var wrappedId: String {
        id ?? "Unknown"
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    

}

// MARK: Generated accessors for of
extension Friend {

    @objc(addOfObject:)
    @NSManaged public func addToOf(_ value: User)

    @objc(removeOfObject:)
    @NSManaged public func removeFromOf(_ value: User)

    @objc(addOf:)
    @NSManaged public func addToOf(_ values: NSSet)

    @objc(removeOf:)
    @NSManaged public func removeFromOf(_ values: NSSet)

}

extension Friend : Identifiable {

}
