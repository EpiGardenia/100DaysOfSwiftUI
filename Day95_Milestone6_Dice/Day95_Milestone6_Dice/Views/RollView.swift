//
//  RollView.swift
//  Day95_Milestone6_Dice
//
//  Created by T  on 2021-01-19.
//

import SwiftUI

enum maxNumE: Int {
    case fourSided = 4
    case sixSided = 6
    case eightSided = 8
    case tenSided = 10
    case twelveSided = 12
    case twentySided = 20
    case oneHundredSided = 100
}

struct RollView: View {
    @State private var rollAngle: Double = 0.0
    @State private var maxNum: maxNumE = .sixSided
    @State private var value = 0
    let timeOfDice = 40
    @State private var timeRemaining = 40 {
        didSet{
            if timeRemaining <= 0 {
                stopDice = true
                rollAngle = 0
            }
        }
    }
    @State private var showingDiceChoices = false
    @State private var stopDice = true {
        didSet {
            print("stopDice = \(stopDice)")
        }
    }
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.largeTitle)
            Image("dice")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotation3DEffect(
                    .degrees(self.rollAngle),
                    axis: (x: 1, y: 1, z: 1)
                )
                .padding()
            
            Button("Choose size of dice") {
                showingDiceChoices = true
            }
            
            Button("Roll") {
                stopDice = false
                self.timeRemaining = timeOfDice
            }.padding()
            .font(.largeTitle)
            .background(Color.orange)
            .clipShape(Capsule())
        }.actionSheet(isPresented: $showingDiceChoices, content: {
            ActionSheet(title: Text("Size of Dice"), message: Text("Select the size of dice"), buttons: [
                .default(Text("4")) { maxNum = .fourSided},
                .default(Text("6")) { maxNum = .sixSided},
                .default(Text("8")) { maxNum = .eightSided},
                .default(Text("10")) { maxNum = .tenSided},
                .default(Text("12")) { maxNum = .twelveSided},
                .default(Text("20")) { maxNum = .twentySided},
                .cancel()
            ])
            
        })
        .onReceive(timer) { time in
            if !stopDice {
                let baseAnimation = Animation.easeInOut
                withAnimation(baseAnimation){
                    self.rollAngle -= 80
                }
                value = Int.random(in: 1...maxNum.rawValue)
                self.timeRemaining -= 1
            }
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
