//
//  Prospect.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-07.
//

import Foundation

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject{
    static let saveKey = "Prospects"
    @Published private(set) var people: [Prospect]
    init() {
        self.people = []
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
            }
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        self.save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Prospect) {
        self.people.append(prospect)
        save()
    }
}
