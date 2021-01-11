//
//  Day81_localNotification.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-04.
//

import SwiftUI

struct Day81_localNotification: View {
    var body: some View {
        VStack{

            Button(action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
                    if success {
                        print("All Set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                })
            }, label: {
                Text("Request Permission")
            }).padding()
            
            Button(action: {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
            }, label: {
                Text("Trigger Notificaiton")
            }).padding()
        }
    }
}

struct Day81_localNotification_Previews: PreviewProvider {
    static var previews: some View {
        Day81_localNotification()
    }
}
