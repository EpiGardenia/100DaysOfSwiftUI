//
//  Facility.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-22.
//

import SwiftUI

struct Facility {
    static func icon(for facility: String) -> some View {
        let icons = [
            "Accommodation": "house",
            "Beginners": "1.circle",
            "Cross-country": "map",
            "Eco-friendly": "leaf.arrow.circlepath",
            "Family": "person.3"
        ]
        
        if let iconName = icons[facility] {
            let image = Image(systemName: iconName)
                .accessibility(label: Text(facility))
                .foregroundColor(.secondary)
            return image
        } else {
            fatalError("Unknown afcility type: \(facility)")
        }
    }
    
    
    static func alert(for facility: String) -> Alert {
        let message = [
            "Accommodation": "This resort has popular on-site accommodation.",
            "Beginners": "This resort has lots of ski schools.",
            "Cross-country": "This resort has many cross-country ski routes.",
            "Eco-friendly": "This resort has won an award for environmental friendliness.",
            "Family": "This resort is popular with families."
        ]
        
        if let message = message[facility] {
            return Alert(title: Text(facility), message: Text(message))
        } else {
            fatalError("Unknown facility type: \(facility)")
        }
    }
}
