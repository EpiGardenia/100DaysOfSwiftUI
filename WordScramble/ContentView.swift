//
//  ContentView.swift
//  WordScramble
//
//  Created by T  on 2020-04-27.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showingAlert = false
    @State private var score = 0
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                    
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("Score: \(score)")
            } // End of VStack
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(errorTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
                        }
            .navigationBarItems(leading: Button(action: startGame){
                Text("New Game")
            })
        }
    }
    
    
    func startGame() {
        newWord = ""
        score = 0
        usedWords.removeAll()
        // 1. find startup txt in our bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. load into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. split that string into an array of string with each element being one word
                let allWords = startWords.components(separatedBy: "\n")
                // 4. pick one random word from there to assigned to root word or use a sensible default if array is empty
                rootWord = allWords.randomElement() ?? "Default"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }

    
    func addNewWord() {
        // 1. Remove whitespace from both ends
        let nonSpaceWord = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 2. Check that at least one character otherwise exit
        guard nonSpaceWord.count > 0 else {
            return
        }
        
        
        guard isOriginal(word: nonSpaceWord) else {
            showErrorMsg(title: "Not Original", msg: "The same word as earlier")
            newWord = ""
            return
        }
        
        guard isPossible(word: nonSpaceWord) else {
            showErrorMsg(title: "Impossible", msg: "Do not contain root")
            newWord = ""
            return
        }
        
        guard isReal(word: nonSpaceWord) else {
            showErrorMsg(title: "Not a real word", msg: "Good try...")
            newWord = ""
            return
        }
        
        score += (10 + nonSpaceWord.count)
        
        // 3. Set that new word as index 0 of usedWords
        usedWords.insert(nonSpaceWord, at: 0)
        
        // 4. Set new word back to empty string
        newWord = ""
    }
    
    
    func showErrorMsg(title: String, msg: String) {
        errorTitle = title
        errorMsg = msg
        showingAlert = true
    }
    
    func isOriginal(word:String) -> Bool {
        return !usedWords.contains(word) && (word != rootWord)
    }
    
    // if new word continas root
    func isPossible(word:String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let index = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return (misspelledRange.location == NSNotFound) && (word.count > 3)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
