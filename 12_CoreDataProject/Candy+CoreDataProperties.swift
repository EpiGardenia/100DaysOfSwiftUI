//
//  Candy+CoreDataProperties.swift
//  12_CoreDataProject
//
//  Created by T  on 2020-09-13.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
