//
//  ContentView.swift
//  PaperScissorsRock
//
//  Created by T  on 2020-04-19.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let gameChoices = ["🖐", "✌️", "✊"]//, Paper", "Scissor", "Rock"]
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
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                Section{
                    Spacer()
                    Text("Computer plays")
                    Text("")
                        .modifier(ButtonStyle(text:" \(self.gameChoices[computerChoiceIndex])"))
                    Spacer()
                }
                Section {
                    Text("To \(relation)")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                Section {
                    Text("You should play")
                    HStack{
                        ForEach(0...2, id:\.self) { index in
                            Button(action: {self.checkAnswer(usersAnswer: index)}){
                                Text("")
                                    .modifier(ButtonStyle(text:" \(self.gameChoices[index])"))
                            }
                        }
                    }
                    Spacer()
                }
                Section {
                    Text("Score: \(self.score)")
                        .modifier(ScoreStyle())
                    
                    Spacer()
                }
                
            }
            .alert(isPresented: $showingResult) {
                Alert(title: Text("\(self.result)"), primaryButton: Alert.Button.default(Text("Continue")), secondaryButton: .default(Text("End Game")))
            }
        }
    }
    
    func checkAnswer(usersAnswer: Int) {
        if usersAnswer == self.correctAnswer {
            score += 1
            result = "Correct"
        } else {
            result = "Incorrect"
        }
        
        showingResult = true
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
    var text: String
    func body(content: Content) -> some View {
        ZStack{
            content
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(width: 100, height: 60, alignment: .center)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
