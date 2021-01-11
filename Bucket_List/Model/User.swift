//
//  User.swift
//  Bucket_List
//
//  Created by T  on 2021-01-01.
//

import Foundation

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        var lessThan = false
        
        if lhs.firstName < rhs.firstName {
            lessThan = true
        } else if lhs.firstName == rhs.firstName {
            lessThan = lhs.lastName < rhs.lastName
        }
        
        return lessThan
    }
}
