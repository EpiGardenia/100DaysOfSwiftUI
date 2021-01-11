//
//  Day87_userNotification.swift
//  Flashzilla
//
//  Created by T  on 2021-01-10.
//

import SwiftUI

struct Day87_userNotification: View {
    @State private var input = ""
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                print("App will resign")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                print("App will come back")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification), perform: { _ in
                print("User takes screenshot")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification), perform: { _ in
                print("User changes the clock")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardDidShowNotification), perform: { _ in
                print("Keyboad is shown ")
            })
        
        TextField("To test keyboard is shown", text: $input)
    }
}

struct Day87_userNotification_Previews: PreviewProvider {
    static var previews: some View {
        Day87_userNotification()
    }
}
