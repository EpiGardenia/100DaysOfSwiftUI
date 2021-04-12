//
//  SaveFile.swift
//  BucketList
//
//  Created by T  on 2020-10-30.
//

import Foundation

extension FileManager {
    static func saveTo(fileName: String, with str: String) {
        let currentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = currentPath.appendingPathComponent(fileName)
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let urlContent = try String(contentsOf: url)
            print(urlContent)
        }
        catch {
            print(error.localizedDescription)
        }
        
        
    }
}
