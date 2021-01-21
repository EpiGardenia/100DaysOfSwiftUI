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

    var description: String {
        switch self {
        case .fourSided: return "Four Sided"
        case .sixSided: return "Six Sided"
        case .eightSided: return "Eight Sided"
        case .tenSided: return "Ten Sided"
        case .twelveSided: return "Twelve Sided"
        case .twentySided: return "Twenty Sided"
        case .oneHundredSided: return "One Hundred Sided"
        }
    }
}

extension maxNumE: Codable{
    enum Key: CodingKey{
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 4:
            self = .fourSided
        case 6:
            self = .sixSided
        case 8:
            self = .eightSided
        case 10:
            self = .tenSided
        case 12:
            self = .twelveSided
        case 20:
            self = .twentySided
        case 100:
            self = .oneHundredSided
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .fourSided:
            try container.encode(4, forKey: .rawValue)
        case .sixSided:
            try container.encode(6, forKey: .rawValue)
        case .eightSided:
            try container.encode(8, forKey: .rawValue)
        case .tenSided:
            try container.encode(10, forKey: .rawValue)
        case .twelveSided:
            try container.encode(12, forKey: .rawValue)
        case .twentySided:
            try container.encode(20, forKey: .rawValue)
        case .oneHundredSided:
            try container.encode(100, forKey: .rawValue)
        }
    }
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

struct DiceData: Codable, Hashable {
    let diceValue: Int
    let diceType: maxNumE
    static var example = DiceData(diceValue: 1, diceType: maxNumE.sixSided)

}


