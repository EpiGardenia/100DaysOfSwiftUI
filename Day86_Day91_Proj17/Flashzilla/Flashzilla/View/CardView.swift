//
//  CardView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var
        differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var
        accessibilityEnabled
    let card: Card
    var removal: (() -> Void)? = nil {
        didSet{
            print("DidSet removal")
        }
        willSet{
            print("willSet removal")
        }
    }
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var cardColor = Color.white
    @State private var showingCross = false
    @State private var showingCheck = false
    @State private var feedback = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                .fill(differentiateWithoutColor ? Color.white : Color.white.opacity(1 - Double(abs(offset.width/50))))
                .background(differentiateWithoutColor ? nil :
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack{
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.question)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.question)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 300, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .rotationEffect(.degrees(Double(offset.width/5)))
        .offset(x:offset.width*5, y:0)
        .opacity(2 - Double(abs(offset.width/50)))
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                    if self.removal == nil {
                        print("self.removal = nil onChanged")
                    }
                }
                .onEnded{ _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                        } else {
                            self.feedback.notificationOccurred(.error)
                            
                        }
                        print("self.removal:\(String(describing: self.removal))")
                        if self.removal == nil {
                            print("self.removal = nil before")
                        }
                        self.removal?()
                        if self.removal == nil {
                            print("self.removal = nil after.")
                        }
                    } else {
                        //return back to center
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring())
        .onAppear{
            if self.removal == nil {
                print("self.removal = nil onAppear Card")
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
