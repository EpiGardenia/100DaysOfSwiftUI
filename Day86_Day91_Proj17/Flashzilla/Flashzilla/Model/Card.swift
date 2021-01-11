//
//  Card.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import Foundation

struct Card {
    var question: String
    var answer: String
    static var example: Card {
        Card(question: "Where does Totoro live?", answer: "Japan")
    }
}
