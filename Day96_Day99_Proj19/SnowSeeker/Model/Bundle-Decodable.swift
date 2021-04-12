//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-21.
//

import Foundation


extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
    
    func decode<T: Decodable>(_ url: URL) -> T {
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(url) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(url) from bundle.")
        }
        return loaded
    }
    
    
    func encode<T:Encodable>(data: T, url: URL) {
        guard let encoded = try? JSONEncoder().encode(data) else {
            fatalError("Failed to encode \(data) from bundle.")
        }
        
        do {
            try encoded.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
