//
//  Bundle_decode.swift
//  FriendFace
//
//  Created by T  on 2020-09-17.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import Foundation

extension Bundle {
    
    func decode<T:Codable>  (from fileURL: String) -> T {
        guard let url = Bundle.main.url(forResource: fileURL, withExtension: nil)  else {
            fatalError("Wrong URL")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can't fetch Data")
        }
        

        let decoder = JSONDecoder()
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Can't decode")
        }
        
        
        
        
        return decoded
    }
    
    
}
