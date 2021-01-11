//
//  CardsView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import SwiftUI

struct CardsView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                ZStack{
                    ForEach(0..<cards.count, id:\.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation{
                                self.removeCard(at: index)
                            }
                        }
                            .stacked(at: index, in: self.cards.count)
                    }
                }
            }
        }
    }
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

extension View {
    func stacked(at position: Int, in total: Int)
    -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset*10))
    }
}


struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
            CardsView()
    }
}
