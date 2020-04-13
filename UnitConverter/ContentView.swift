//
//  ContentView.swift
//  UnitConverter
//  Challenge Day:
//  https://www.hackingwithswift.com/100/swiftui/19
//  Created by T  on 2020-04-13.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tempInput = ""
    let tempUnits = ["Celsius", "Fahrenheit", "Kevin"]
    @State private var inputTempUnitIndex = 0
    @State private var outputTempUnitIndex = 0
    private var tempResult: Double {
        let inputValue = Double(tempInput) ?? 0
        var outputValue: Double = 0.0
        switch inputTempUnitIndex {
        case 0:
            outputValue = fromCesiusTo(unitIndex: outputTempUnitIndex, value: inputValue)
        case 1:
            outputValue =  fromFahrenheitTo(unitIndex: outputTempUnitIndex, value: inputValue)
        case 2:
            outputValue = fromKelvinTo(unitIndex: outputTempUnitIndex, value: inputValue)
        default:
            assertionFailure()
        }
        return outputValue
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Temperature ")){
                    HStack{
                        Text("Convert")
                        Spacer()
                        TextField("Value", text: ($tempInput))   .padding(.leading, 113)
                            .keyboardType(.decimalPad)
                        Spacer()
                    }
                    Picker("TempUnits", selection: $inputTempUnitIndex ) {
                        ForEach(0..<tempUnits.count) {
                            Text("\(self.tempUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    HStack {
                        Text("To")
                        Spacer()
                        Text(" \(tempResult, specifier: "%.2f")")
                        Spacer()
                    }
                    Picker("TempUnits", selection: $outputTempUnitIndex ) {
                        ForEach(0..<tempUnits.count) {
                            Text("\(self.tempUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

private func fromCesiusTo(unitIndex: Int, value: Double) -> Double {
    switch unitIndex {
    case 1:
        return celsius2Fahrenheit(cValue: value)
    case 2:
        return celsius2Kelvin(cValue: value)
    default:
        return value
    }
}

private func fromFahrenheitTo(unitIndex: Int, value: Double) -> Double {
    switch unitIndex {
    case 0:
        return fahrenheit2Celsius(fValue: value)
    case 2:
        return fahrenheit2Kelvin(fValue: value)
    default:
        return value
    }
}


private func fromKelvinTo(unitIndex: Int, value: Double) -> Double {
    switch unitIndex {
    case 0:
        return kevin2Celsius(kValue: value)
    case 1:
        return kevin2Fahrenheit(kValue: value)
    default:
        return value
    }
}


private func celsius2Kelvin(cValue: Double) -> Double{
    return cValue + 273.15
}

private func celsius2Fahrenheit(cValue: Double) -> Double{
    return cValue * 1.8 + 32
}

private func fahrenheit2Kelvin(fValue: Double) -> Double{
    return (fValue + 459.67) * 5 / 9
}

private func fahrenheit2Celsius(fValue: Double) -> Double{
    return (fValue - 32) * 5 / 9
}

private func kevin2Fahrenheit(kValue: Double) -> Double{
    return kValue * 1.8 - 459.67
}

private func kevin2Celsius(kValue: Double) -> Double{
    return kValue - 273.15
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
