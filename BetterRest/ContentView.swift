//
//  ContentView.swift
//  BetterRest
//
//  Created by T  on 2020-04-24.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeupTime = defaultWakeUpTime
    @State private var cups = 2
    @State private var sleepHours = 8.0
    @State private var showAlert = false
    @State private var alertMsg = ""
    @State private var alertTitle = ""
    // static: so it belongs to ContentView
    static var defaultWakeUpTime: Date {
        var component = DateComponents()
        component.hour = 8
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date()
    }
    
    func calculateBedTime() {
        let wakeUpTimeComponent = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
        let hourInSec = (wakeUpTimeComponent.hour ?? 0) * 60 * 60
        let minuteInSec = (wakeUpTimeComponent.minute ?? 0) * 60
        do{
            let sleepOutput = try SleepCalculator().prediction(wake: Double(hourInSec + minuteInSec), estimatedSleep: sleepHours, coffee: Double(cups))
            let sleepInSec =  wakeupTime - sleepOutput.actualSleep
            let format = DateFormatter()
            format.timeStyle = .short
            alertTitle = "You could sleep at"
            alertMsg = format.string(from: sleepInSec)
        }
        catch {
            alertTitle = "Error"
            alertMsg = "We can't get result"
        }
        showAlert = true
    }
    
    var body: some View {
        NavigationView{
        Form {
            VStack(alignment: .leading, spacing:0){
                // Wanted wake up time
                Text("When do you want to wake up?").font(.headline)
                DatePicker("I want to wake up at",
                           selection: $wakeupTime,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
            }
            VStack(alignment: .leading, spacing:0){
                // Wanted length of sleep
                Text("Amount of desired sleep").font(.headline)
                Stepper("\(sleepHours, specifier: "%g") hours", value: $sleepHours, in:0...24, step: 1)
            }
            VStack(alignment: .leading, spacing:0){
                // Nr. Coffee drink per day
                Text("Amount of coffee intake").font(.headline)
                Stepper(value: $cups, in: 0...20){
                    if cups < 2 {
                        Text("\(cups, specifier: "%d") cup")
                    } else {
                        Text("\(cups, specifier: "%d") cups")
                    }
                }
            }
        }
        .navigationBarTitle("Better Rest").preferredColorScheme(.some(.light)).foregroundColor(.blue)
        .navigationBarItems(trailing:   Button(action: calculateBedTime) {
            Text("Calculate").foregroundColor(.purple).font(.headline)
        })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            })
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
