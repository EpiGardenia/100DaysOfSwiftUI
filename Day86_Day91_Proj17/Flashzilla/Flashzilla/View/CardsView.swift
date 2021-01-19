//
//  CardsView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-11.
//

import SwiftUI

struct CardsView: View {
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differatiateWithoutColor
    @State private var cards = [Card]()
    @State private var time = 100
    @State private var isActive = true
    @State private var isTimeOut = false
    @State private var showingEditScreen = false
    @State private var showingSetting = false
    @State private var hasSecondChance = false
    var timer = Timer.publish(every: 1, tolerance: 0.2, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Time: \(time)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                ZStack{
                    ForEach(0..<cards.count, id:\.self) { index in
                        CardView(card: cards[index], removal: {
                            withAnimation{
                                self.removeCard(at: index)
                            }
                        })
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }  
                }
                .allowsHitTesting(self.time > 0)
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .font(.title)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
                if differatiateWithoutColor || accessibilityEnabled {
                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }){
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        Button(action: {
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }, label:{
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        })
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                        Spacer()
                        
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                } else {
                    Spacer()
                }
            }
            .onReceive(timer, perform: { time in
                guard self.isActive else { return }
                if self.time > 0 {
                    self.time -= 1
                    if self.time == 0 {
                        self.isTimeOut = true
                    }
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                isActive = false
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                if self.cards.isEmpty == false {
                    isActive = true
                }
            })
            .onAppear(perform: loadData)
            
            VStack{
                HStack{
                    Image(systemName: "gear")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                        .onTapGesture {
                            showingSetting = true
                        }
                        .actionSheet(isPresented: $showingSetting, content: {
                            ActionSheet(title: Text("Give a wrong answer second try?"),
                                        buttons: [
                                            .default(Text("Yes")){ self.hasSecondChance = true},
                                            .default(Text("No")){ self.hasSecondChance = false}
                                                     ])
                                        })
                    Spacer()
                    Button(action: { showingEditScreen = true}, label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                        
                    })
                    
                }
                Spacer()
            }
            
        }
        .sheet(isPresented: $showingEditScreen, content: {AddCardView()})
        .onAppear(perform: resetCards)
        .alert(isPresented: $isTimeOut, content: {
            Alert(title: Text("Time Out"))
        })
        // .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else {return}
//        var card = cards[index]
//        if !card.hasFailed {
//            cards.append(card)
//        }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        loadData()
        isActive = true
        time = 5 * cards.count
        isTimeOut = false
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
