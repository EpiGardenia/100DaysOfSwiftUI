//
//  AccessDirectoryView.swift
//  Bucket_List
//  To write a string into a file in device,
//  and be able to read it from device
//  Created by T  on 2021-01-01.
//

import SwiftUI

struct AccessDirectoryView: View {
    @State private var textToSaved = ""
    @State private var showingSaveOK = false
    let fileName = "AccessTest.txt"
    
    
    var body: some View {
        TextField("Text to Save", text: $textToSaved)
        Button("Save") {
            let fileToBeWritten = openFile(fileName: fileName)
            writeFile(dataToWrite: textToSaved, toFile: fileToBeWritten)
            if readFile(fileUrl: fileToBeWritten) == textToSaved {
                showingSaveOK = true
            }
        }.alert(isPresented: $showingSaveOK, content: {
            Alert(title: Text("Save OK"))
        })
    }
}

struct AccessDirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        AccessDirectoryView()
    }
}
