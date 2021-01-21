//
//  LogView.swift
//  Day95_Milestone6_Dice
//
//  Created by T  on 2021-01-19.
//

import SwiftUI
struct LogView: View {
   // @State private var diceDatas: [DiceData] = [DiceData]()
    @State private var diceDatas: [Int] = []
    var body: some View {
        NavigationView {
          //  VStack{
            List(diceDatas, id:\.self){ data in
               // ForEach(0..<diceDatas.count, id:\.self) { index in
                    Text(String(data))
          //      }
            }.navigationTitle("History")
        }
        .onAppear(
            perform:{self.loadData()}
        )
    }

    func loadData() {
        print("loadData")
      //  if let data = UserDefaults.standard.data(forKey: "DiceValue") {
            if let data = UserDefaults.standard.array(forKey: "DiceValue") as? [Int] {
                print("data: \(data)")
                self.diceDatas = data
            }
            
            
//            print("data: \(data)")
//            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
//                print("Decoded: \(decoded)")
//                self.diceDatas = decoded
//            }
//        }
    }
    
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
