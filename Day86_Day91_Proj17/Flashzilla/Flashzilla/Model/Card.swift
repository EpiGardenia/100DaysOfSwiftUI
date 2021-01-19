//
//  Card.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import Foundation

struct Card: Codable {
    let question: String
    let answer: String
    // check if the card has been guessed wrong in the same round
    var hasFailed = false
    static var example: Card {
        Card(question: "Where does Totoro live?", answer: "Japan")
    }
}
