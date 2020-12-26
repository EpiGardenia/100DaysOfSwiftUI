//
//  Contact.swift
//  IRemember
//
//  Created by T  on 2020-12-26.
//
import Foundation

struct Contact: Identifiable, Comparable, Codable{
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    let name: String
  //  let photo: Data
}
