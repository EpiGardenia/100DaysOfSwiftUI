//
//  FileAccess.swift
//  Bucket_List
//  Open, Read, and Write file
//  Created by T  on 2021-01-01.
//

import Foundation

// open a file in documentsDirectory
func openFile(fileName: String) -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = directory.appendingPathComponent(fileName)
        return url
}

func readFile(fileUrl: URL) -> String? {
    do {
        let data = try String(contentsOf: fileUrl)
        return data
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

func writeFile(dataToWrite: String, toFile: URL) {
    do {
        try dataToWrite.write(to: toFile, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
    }
}



