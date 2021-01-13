//
//  Card.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import Foundation

struct Card: Codable {
   // var id = UUID()
    let question: String
    let answer: String
    static var example: Card {
        Card(question: "Where does Totoro live?", answer: "Japan")
    }
}
