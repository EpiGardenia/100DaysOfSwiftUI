//
//  DataHandling.swift
//  Day95_Milestone6_Dice
//
//  Created by T  on 2021-01-19.
//

import Foundation

enum maxNumE: Int {
    case fourSided = 4
    case sixSided = 6
    case eightSided = 8
    case tenSided = 10
    case twelveSided = 12
    case twentySided = 20
    case oneHundredSided = 100
}

//class diceDatas: Codable {
//    var diceDatas: [DiceData]
//    // load
//    init() {
//        if let data = UserDefaults.standard.data(forKey: "diceDatas") {
//            if let decoded = try? JSONDecoder().decode([DiceData].self, from: data) {
//                self.diceDatas = decoded
//                return
//            }
//        }
//    }
//    self.diceDatas = []
//}

struct DiceData: Codable {
    let diceValue: Int
    //let diceType: maxNumE
    static var example = DiceData(diceValue: 1)
  //  static var example = DiceData(diceValue: 1, diceType: .sixSided)
    
    

}


