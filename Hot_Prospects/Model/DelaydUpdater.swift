//
//  DelaydUpdater.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-03.
//

import Foundation

class DelayedUpdater: ObservableObject {
   // @Published
    var value = 0 {
        willSet{
            objectWillChange.send()
        }
    }
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now()+Double(i), execute: {self.value+=1;  print(self.value)})
        }
    }
}
