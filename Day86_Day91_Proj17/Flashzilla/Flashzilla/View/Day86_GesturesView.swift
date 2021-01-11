//
//  Day86_GesturesView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-09.
//

import SwiftUI

struct Day86_GesturesView: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(0)
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in self.offset =
                value.translation
            }
            .onEnded { _ in
                withAnimation{
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation{
                    self.isDragging = true
                }
            }

        VStack{
            Text("Tap Gesture")
                .onTapGesture {
                    print("You are Tapping!")
                }
                .padding()
            Text("Double Tap Gesture")
                .onTapGesture(count: 2, perform: {
                    print("You are double tapping!")
                })
                .padding()
            
            Text("Long Press Gesture")
                .onLongPressGesture(
                    minimumDuration: 2,
                    maximumDistance: 2.5,
                    pressing: { inProgress in
                        print("In Progress: \(inProgress)!")},
                    perform: { print("Long pressing") })
                .padding()
            
            Text("Magnification Gesture")
                .scaleEffect(finalAmount+currentAmount)
                .gesture(
                    MagnificationGesture()
                        
                        .onChanged { amount in
                            self.currentAmount = amount - 1
                        }
                        .onEnded{ amount in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = 0
                        }
                )
                .padding()

            Text("Rotation Gesture")
                .rotationEffect(finalAngle + currentAngle)
                .gesture(
                    RotationGesture()
                        .onChanged{ angle in
                            self.currentAngle = angle
                        }
                        .onEnded{ angle in
                            self.finalAngle += self.currentAngle
                            self.currentAngle = .degrees(0)
                        }
                )
                .padding()

            // Long press then drag
            Circle()
                .fill(Color.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(pressGesture.sequenced(before: dragGesture))
        }
        .simultaneousGesture(    // show both parent and child
            //.highPriorityGesture(  // show Vstack
            TapGesture(count: 2)
                .onEnded({
                    print("VStack double tapping!")
                }))
        
    }
}

struct Day86_GesturesView_Previews: PreviewProvider {
    static var previews: some View {
        Day86_GesturesView()
    }
}
