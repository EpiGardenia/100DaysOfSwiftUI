//
//  FileAccess.swift
//  Hot_Prospects
//  Save and load data into document directory (challenge 2)
//  Created by T  on 2021-01-08.
//

import Foundation


func loadData(file: String) -> [Prospect]? {
    let url = getFilePath(fileName: file)
    if let data = try? Data(contentsOf: url) {
       return jsonDecode(data)
    }
    return nil
}

func saveData(of people: [Prospect],  to file: String) {
    let url = getFilePath(fileName: file)
    let encoded = jsonEncode(people: people)
    do {
        try encoded?.write(to: url)
    } catch {
        print(error.localizedDescription)
    }
}

private func getFilePath(fileName: String) -> URL {
    let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let url = docDir.appendingPathComponent(fileName)
    return url
}


private func jsonDecode(_ data: Data) -> [Prospect]? {
    let decoder = JSONDecoder()
    do {
        let decoded = try decoder.decode([Prospect].self, from: data)
        return decoded
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

private func jsonEncode(people: [Prospect]) -> Data? {
    let encoder = JSONEncoder()
    do {
        let encoded = try encoder.encode(people)
        return encoded
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

