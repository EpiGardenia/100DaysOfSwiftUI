//
//  Prospect.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-07.
//

import Foundation

class Prospect: Identifiable, Codable, Comparable{
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
    
}

class Prospects: ObservableObject{
    static let saveKey = "Prospects"
    static let fileName = "Prospects.txt"
    @Published private(set) var people: [Prospect]
    init() {
        self.people = loadData(file: Self.fileName) ?? []
//        if let url = getFilePath(fileName: Prospects.fileName){
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: url) {
//                self.people = decoded
//            }
//        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        self.save()
    }
    
    func add(_ prospect: Prospect) {
        self.people.append(prospect)
        save()
    }
    
    private func save() {
        saveData(of: people, to: Self.fileName)
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
    }

    
}
