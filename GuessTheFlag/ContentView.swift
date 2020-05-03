//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by T  on 2020-04-19.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var  countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingResult = false
    @State private var score = 0
    @State private var result = ""
    @State private var msg = ""
    @State private var rotateAmount = 0.0
    @State private var ans = false
    @State private var xAxis = CGFloat.init()
    @State private var yAxis = CGFloat.init()
    @State private var selection: Int? = nil

    var body: some View {
        ZStack{
            //Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10){
                VStack{
                Text("Tap")
                Text("\(countries[correctAnswer])")
                    .fontWeight(.heavy)
                    .titleStyle()
                }
                ForEach(0..<3) { number in
                    Button(action:{
                        self.selection = number
                        self.ans = self.checkAnswer(countryIndex: number)
                        withAnimation{
                            self.rotateAmount += 360
                            
                        }
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(color: .black, radius: 5, x: 2, y: 2)
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                    }
              
                            .rotation3DEffect(.degrees(self.selection == number ? self.rotateAmount : 0), axis: (x: (self.ans ? 1 : 0), y: (self.ans ? 0 : 1), z: 0))
                        .opacity((self.ans && (self.selection != number)) ? 0.5 : 1)
                   }
                Text("Score:\(score)")
        }
    }                        .alert(isPresented: $showingResult){
    Alert(title: Text("\(self.result)"), message: Text("\(self.msg)"), dismissButton: .default(Text("Continue")){
        self.continueGame()
        })}
        
    }
        
        
    func checkAnswer(countryIndex: Int) -> Bool{
        var correctness = false
        if countryIndex == correctAnswer {
            self.result = "Correct"
            score += 1
            correctness = true
            self.msg = "You got one more score"
            self.xAxis = 1
            // self.yAxis = 0
            
        } else {
            self.result = "InCorrect"
            self.msg = "This is flag of \(self.countries[countryIndex])"
               correctness = false
            self.xAxis = 0
               //    self.yAxis = 1
        }
        showingResult = true
        return correctness
    }
    
    func continueGame() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.purple)
    }
}

extension View{
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
