//
//  Day87_special_accessibility.swift
//  Flashzilla
//
//  Created by T  on 2021-01-10.
//

import SwiftUI
func withOptionAnimation<Result>(_ animation: Animation? = .default,
                                 _ body: () throws -> Result) rethrows -> Result {
                                    if UIAccessibility.isReduceMotionEnabled {
                                        return try body()
                                    } else {
                                        return try withAnimation(animation, body)
                                    }
                                 }


struct Day87_special_accessibility: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var
        differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var
        reduceMotion
    @Environment(\.accessibilityReduceTransparency) var
        reduceTransparency
    
    @State private var scale: CGFloat = 1
    var body: some View {
        VStack{
            HStack{
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                Text("Success")
                    .scaleEffect(scale)
                    .onTapGesture {
                        if self.reduceMotion {
                            self.scale *= 1.5
                        } else {
                            withOptionAnimation{
                                self.scale *= 1.5
                            }
                        }
                    }
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            Text("Support Reduced Transparency")
                .padding()
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .clipShape(Rectangle())
        }
    }
}

struct Day87_special_accessibility_Previews: PreviewProvider {
    static var previews: some View {
        Day87_special_accessibility()
    }
}
