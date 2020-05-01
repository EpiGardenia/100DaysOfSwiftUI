//
//  ContentView.swift
//  Animations
//
//  Created by T  on 2020-04-30.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let letter = Array("Hello Taiwan")
    
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letter.count) { num in
                Text(String(self.letter[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double (num)/20))
                
            }
        }
        .gesture(
            DragGesture()
                .onChanged{self.dragAmount = $0.translation}
                .onEnded{ _ in
                    withAnimation(.spring()) {
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    }}
        )
    }
}

//
//LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
//.frame(width: 300, height: 200, alignment: .trailing )
//.clipShape(RoundedRectangle(cornerRadius: 20))
//.offset(dragAmount)
//.gesture(
//    DragGesture()
//        .onChanged{ self.dragAmount = $0.translation}
//        .onEnded{ _ in
//            withAnimation(.spring()) {
//                self.dragAmount = .zero
//            }
//    }
//)

    
        
//        Button("Tap me") {
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                self.animationAmout += 360
//            }
 //       }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(.degrees(animationAmout), axis: (x: 0, y: 1, z: 1))
        
        //        .overlay(
        //            Circle()
        //                .stroke(Color.red)
        //                .scaleEffect(animationAmout)
        //                .opacity(Double(2-animationAmout))
//                .animation(
//                    Animation.easeInOut(duration: 2)
//                        .repeatForever(autoreverses: false)
//
//                    // .delay(3))
//            )
//            //.blur(radius: (animationAmout - 1) * 2)
//            //.animation(.interpolatingSpring(stiffness: 10, damping: 5))
//            //   .animation(.easeInOut(duration: 2))
//
//        )
//            .onAppear(){
//                self.animationAmout = 2
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
