//
//  Movie+CoreDataProperties.swift
//  12_CoreDataProject
//
//  Created by T  on 2020-09-13.
//  Copyright © 2020 AlaacLux. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    
    public var wrappedTitle: String {
        return title ?? "Unknown title"
    }

}
