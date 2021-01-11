//
//  Day87_triggerTimerView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-10.
//

import SwiftUI

struct Day87_triggerTimerView: View {
    var timer = Timer.publish(every: 2, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State var counter = 0
    var body: some View {
        Text("Timer will kick 5 times")
            .onReceive(timer, perform: { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("Time: \(time)")
                    self.counter += 1
                }
            })
    }
}

struct Day87_triggerTimerView_Previews: PreviewProvider {
    static var previews: some View {
        Day87_triggerTimerView()
    }
}
