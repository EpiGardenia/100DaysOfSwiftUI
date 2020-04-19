//
//  ContentView.swift
//  PaperScissorsRock
//
//  Created by T  on 2020-04-19.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let gameChoices = ["🖐", "✌️", "✊"]
    @State private var relation =  Bool.random() ? "WIN" : "LOSE"
    @State private var computerChoiceIndex = Int.random(in: 0...2)
    @State private var usersAnswer = 0
    @State private var score = 0
    @State private var showingResult = false
    @State private var result = ""
    private var correctAnswer: Int {
        return (relation == "WIN") ? ( (computerChoiceIndex + 1) % 3) :
            ((computerChoiceIndex + 2) % 3)
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.purple, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                Spacer()
                Section{
                    Text("Computer plays")
                    Text("\(self.gameChoices[computerChoiceIndex])")
                        .styledButton()
                }
                Spacer()
                Section {
                    Text("To \(relation)")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                Spacer()
                Section {
                    Text("You should play")
                    HStack{
                        ForEach(0...2, id:\.self) { index in
                            Button(action: {self.checkAnswer(usersAnswer: index)}) {
                                Text(" \(self.gameChoices[index])")
                                    .styledButton()
                            }
                        }
                    }
                }
                Spacer()
                Section {
                    Text("Score: \(self.score)")
                        .modifier(ScoreStyle())
                    
                }
                Spacer()
                Text("@AlaacLux")
                    .foregroundColor(.gray)
            }
            .alert(isPresented: $showingResult) {
                Alert(title: Text("\(self.result)"),
                      primaryButton: .default(Text("Continue")) {
                        self.continueGame()},
                      secondaryButton: .default(Text("New Game")) {
                        self.newGame()})
                
            }
        }
    }
    
    func checkAnswer(usersAnswer: Int) {
        if usersAnswer == self.correctAnswer {
            score += 1
            result = "Correct"
        } else {
            score -= 1
            result = "Incorrect"
        }
        showingResult = true
    }
    
    func continueGame() {
        computerChoiceIndex = Int.random(in: 0...2)
        relation =  Bool.random() ? "WIN" : "LOSE"
    }
    
    func newGame(){
        continueGame()
        score = 0
    }
}

struct ScoreStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 300, height: 10, alignment: .center)
            .padding()
            .background(Color.black)
    }
}

struct ButtonStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.orange)
            .frame(width: 100, height: 60, alignment: .center)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 70))
    }
}

extension View {
    func styledButton() -> some View {
        self.modifier(ButtonStyle())
    }
    func styledScore(with score: String) -> some View {
        self.modifier(ScoreStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
