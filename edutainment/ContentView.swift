//
//  ContentView.swift
//  edutainment
//
//  Created by T  on 2020-05-03.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let options = ["5", "10", "20", "All"]
    @State private var history: [String] = []
    @State private var stringTohistory = ""
    @State private var nrQuestion = 0
    @State private var multTable = 5
    @State private var optionIndex = 0
    @State private var multiplicand = 0
    @State private var multiplier = 0
    @State private var ans = ""
    @State private var question = ""
    @State private var score = 0
    @State private var showingQuestion = false
    @State private var showingAlert = false
    @State private var questionSet : [(Int, Int, Int)] = []
    @State private var oneSet: (Int, Int, Int) = (0, 0, 0)
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Stepper("Multiplication table from 1 to \(self.multTable)", value: self.$multTable, in: 1...12)
                    HStack(){
                        Text("Test me")
                        Picker(selection: $optionIndex, label:Text("")){
                            ForEach(0 ..< options.count) {
                                Text(self.options[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Text("questions")
                    }
                    
                    Button("Game Start", action:newGame)
                        .styleButton()
                }
                Section {
                    if showingQuestion {
                        Text(question)
                        HStack{
                            TextField("Answer:", text: $ans).keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button("Send") {
                                self.checkAnswer()
                            }.styleButton()
                        }
                    }
                }
                Section {
                    Text("Score: \(self.score)")
                }
                
                List(history, id:\.self) {
                    Text($0)
                }
                
            }.navigationBarTitle("Multiplication Game")
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("Great Job!"), message: Text("Your score is \(score)"), primaryButton: .default(Text("Continue")){self.newGame()}, secondaryButton: .default(Text("End Game")))
            }
        }
    }
    
    func checkAnswer() {
        self.stringTohistory.append(self.ans)
        if self.ans == String(oneSet.2) {
            score += 1
            stringTohistory.insert(contentsOf: "✅  ", at: stringTohistory.startIndex)
        } else {
            stringTohistory.insert(contentsOf: "❌  ", at: stringTohistory.startIndex)
        }
        history.append(stringTohistory)
        if questionSet.count > 0 {
            newTurn()
        } else {
            showingAlert = true
        }
        
        UIApplication.shared.endEditing()
    }
    
    func newTurn() {
        self.oneSet = questionSet.popLast() ?? (0,0,0)
        guard self.oneSet != (0,0,0) else {
            fatalError("newTurn when questionSet is empty")
        }
        stringTohistory = "\(self.oneSet.0) x \(self.oneSet.1) = "
        question = "Question \(nrQuestion - self.questionSet.count) of \(nrQuestion):           \(self.stringTohistory) ?"
        self.ans = ""
    }
    
    func newGame() {
        self.score = 0
        history.removeAll()
        showingQuestion = true
        showingAlert = false
        nrQuestion = getNrQuestion()
        questionSet = getQALists()
        newTurn()
    }
    
    func getNrQuestion() -> Int {
        switch optionIndex {
        case 0:
            return 5
        case 1:
            return 10
        case 2:
            return 20
        case 3:
            return multTable * multTable
        default:
            fatalError("outside of option range")
        }
    }
    
    func getQALists() -> [(Int, Int, Int)] {
        var qaList: [(Int, Int, Int)] = []
        
        // get all combinations
        for multiplicand in 1...multTable {
            for multiplier in 1...multTable {
                qaList.append((multiplicand, multiplier, multiplicand * multiplier))
            }
        }
        // Randomly choose unique question sets
        return qaList.randomN(n: nrQuestion)
    }
}

// get N random elements from array
// if N > array size, return duplicated random items
extension Array {
    func randomN(n: Int) -> [Element] {
        var result: [Element] = []
        var candidateList = self
        var timesLeft = n
        if n > self.count {
            while timesLeft > 0 {
                var times = timesLeft > self.count ? self.count : timesLeft
                timesLeft -= times
                candidateList = self
                while (times > 0) {
                    let index = Int.random(in: 0..<candidateList.count)
                    result.append(candidateList.remove(at: index))
                    times -= 1
                }
            }
        }
        else {
            timesLeft = n
            while (timesLeft > 0) {
                let index = Int.random(in: 0..<candidateList.count)
                result.append(candidateList.remove(at: index))
                timesLeft -= 1
            }
        }
        return result
    }
}



struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.yellow)
            .frame(width: 120, height: 30, alignment: .center)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
    }
}


extension View {
    func styleButton() -> some View {
        self.modifier(ButtonStyle())
    }
}


// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
