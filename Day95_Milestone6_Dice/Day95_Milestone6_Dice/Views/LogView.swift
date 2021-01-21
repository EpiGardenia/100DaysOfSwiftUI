//
//  LogView.swift
//  Day95_Milestone6_Dice
//
//  Created by T  on 2021-01-19.
//

import SwiftUI
struct LogView: View {
    @State private var diceDatas: [DiceData] = []
    var body: some View {
        NavigationView {
            VStack{
                List(diceDatas, id:\.self){ data in
                    HStack{
                        Text(String(data.diceValue))
                        Spacer()
                        Text(data.diceType.description)
                    }
                }.navigationTitle("History")
                Button("Clear Data") {
                    diceDatas = []
                    UserDefaults.standard.set([], forKey: "DiceValue")
                }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear(
            perform:{self.loadData()}
        )
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "DiceValue") {
            if let decoded = try? JSONDecoder().decode([DiceData].self, from: data) {
                self.diceDatas = decoded
            }
        }
    }
    
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
