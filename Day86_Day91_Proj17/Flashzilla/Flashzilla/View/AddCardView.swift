//
//  AddCardView.swift
//  Flashzilla
//
//  Created by T  on 2021-01-13.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var question = ""
    @State private var answer = ""
    @State private var cards = [Card]()
    var body: some View {
        NavigationView{
            List{
                Section(header:Text("ADD NEW CARD")){
                    TextField("Question", text: $question)
                    TextField("Answer", text: $answer)
                    Button("Add Card", action: { saveCard() })
                }
                Section{
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading){
                            Text(cards[index].question)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(cards[index].answer)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }.onDelete(perform: removeCard)
                }
            }
            .navigationTitle("Edit Cards")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .listStyle(GroupedListStyle())
            .onAppear(perform: { loadData()})
        }
    }
    
    func removeCard(at offset: IndexSet) {
        cards.remove(atOffsets: offset)
        saveData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func saveCard() {
        let trimmedPrompt = self.question.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = self.answer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let newCard = Card(question: trimmedPrompt, answer:trimmedAnswer)
        //let newCard = Card(question: self.question, answer: self.answer)
        //cards.insert(newCard, at: 0)
         self.cards.append(newCard)
        saveData()
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: "Cards")
        }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}
