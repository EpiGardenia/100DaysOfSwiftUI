//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by T  on 2020-10-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tag: NSSet?
    @NSManaged public var friend: NSSet?
    
    public var wrappedId: String {
        id ?? "<Unknown>"
    }
    
    public var wrappedName: String {
        name ?? "<Unknown>"
    }
    
    
    public var wrappedCompany: String {
        company ?? "<Unknown>"
    }
    
    public var wrappedEmail: String {
        email ?? "<Unknown>"
    }
    
    public var wrappedAddress: String {
        address ?? "<Unknown>"
    }
    
    public var wrappedAbout: String {
        about ?? "<Unknown>"
    }
    
    public var wrappedRegistered: String {
        registered ?? "<Unknown>"
    }
    
    public var tagArray: [Tag] {
        let set = tag as? Set<Tag> ?? []
        return set.sorted{
            $0.wrappedTag < $1.wrappedTag
        }
    }
    
    
    public var friendArray: [Friend] {
        let set = friend as? Set<Friend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    

}

// MARK: Generated accessors for tag
extension User {

    @objc(addTagObject:)
    @NSManaged public func addToTag(_ value: Tag)

    @objc(removeTagObject:)
    @NSManaged public func removeFromTag(_ value: Tag)

    @objc(addTag:)
    @NSManaged public func addToTag(_ values: NSSet)

    @objc(removeTag:)
    @NSManaged public func removeFromTag(_ values: NSSet)

}

// MARK: Generated accessors for friend
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: Friend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: Friend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension User : Identifiable {

}
