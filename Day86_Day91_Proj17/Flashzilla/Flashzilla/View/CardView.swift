//
//  CardView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    @State private var showingAnswer = false
    @State private var offset = CGSize.zero
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack{
                Text(card.question)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
                if showingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .rotationEffect(.degrees(Double(offset.width/5)))
        .offset(x:offset.width*5, y:0)
        .opacity(2 - Double(abs(offset.width/50)))
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    self.offset = gesture.translation }
                .onEnded{ _ in
                    if abs(self.offset.width) > 100 {
                        self.removal?()
                    } else {
                        //return back to center
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            showingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
