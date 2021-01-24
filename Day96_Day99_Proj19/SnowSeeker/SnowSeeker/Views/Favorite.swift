//
//  Favorite.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-22.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorite"
    init() {
        self.resorts = []
        self.load()
    }
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        Bundle.main.encode(data: resorts, url: getFileURL())
    }
    
    func load() {
        resorts = Bundle.main.decode(getFileURL())
    }
    
    
    func getFileURL() -> URL {
        return FileManager.getDocURL(of: "SnowSeeker_favorites.json")
        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let url = paths[0].appendingPathComponent("SnowSeeker_favorites.json")
//        return url
    }
}


extension FileManager {
    static func getDocURL(of fileName: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(fileName)
        return url
    }
}
