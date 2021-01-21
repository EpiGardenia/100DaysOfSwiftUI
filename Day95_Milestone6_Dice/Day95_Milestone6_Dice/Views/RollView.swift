//
//  RollView.swift
//  Day95_Milestone6_Dice
//
//  Created by T  on 2021-01-19.
//

import SwiftUI
import CoreHaptics

struct RollView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var engine: CHHapticEngine?
    @State private var rollAngle: Double = 0.0
    @State private var maxNum: maxNumE = .sixSided
    @State private var values: [DiceData] = []
    @State private var value = 0
    let timeOfDice = 40
    @State private var timeRemaining = 40 {
        didSet{
            if timeRemaining <= 0 {
                stopDice = true
                rollAngle = 0
                addToLog()
                simpleSuccess()
            }
        }
    }
    @State private var showingDiceChoices = false
    @State private var stopDice = true 
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack{
            Text("\(self.value)")
                .font(.largeTitle)
                .foregroundColor(.orange)
            Image("dice")
                .resizable()
                .background(Color.primary)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(30)
                .rotation3DEffect(
                    .degrees(self.rollAngle),
                    axis: (x: 1, y: 1, z: 1)
                )
                .padding()
            Button("Choose size of dice") {
                showingDiceChoices = true
            }.foregroundColor(.primary)
            
            Button("Roll") {
                stopDice = false
                self.timeRemaining = timeOfDice
                
            }.padding()
            .font(.largeTitle)
            .background(Color.orange)
            .foregroundColor(.black)
            .clipShape(Capsule())
        }.actionSheet(isPresented: $showingDiceChoices, content: {
            ActionSheet(title: Text("Size of Dice"), message: Text("Select the size of dice"), buttons: [
                .default(Text("4")) { maxNum = .fourSided},
                .default(Text("6")) { maxNum = .sixSided},
                .default(Text("8")) { maxNum = .eightSided},
                .default(Text("10")) { maxNum = .tenSided},
                .default(Text("12")) { maxNum = .twelveSided},
                .default(Text("20")) { maxNum = .twentySided},
                .default(Text("100")) { maxNum = .oneHundredSided},
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
        .onAppear(){
            prepareHaptics()
            if let data = UserDefaults.standard.array(forKey: "DiceValue") as? [DiceData] {
                self.values = data
            }
        }
    }
    
    func addToLog() {
        let newDice = DiceData(diceValue: self.value, diceType: maxNum)
        values.append(newDice)
        if let encoded = try? JSONEncoder().encode(values) {
            UserDefaults.standard.set(encoded, forKey: "DiceValue")
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware()
                .supportsHaptics else {return}
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
