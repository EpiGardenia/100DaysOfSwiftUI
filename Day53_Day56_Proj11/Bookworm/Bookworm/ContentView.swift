//
//  ContentView.swift
//  Bookworm
//
//  Created by T  on 2020-08-21.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @State var showNewSheet = false
    @State var showDeleteAllAlert = false
    var body: some View {
        
        NavigationView {
            Group {
                Form {
                    
                    ForEach(books, id: \.id) { book in
                        NavigationLink( destination: BookDetail(book: book)) {
                            HStack{
                                EmojiRatingView(rating: book.rating)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(book.title ?? "Unknown")
                                            .font(.headline)
                                            .foregroundColor(book.rating == 1 ? .red : .black)
                                        Text(book.genre ?? "Unknown")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Text(self.formattedDate(of: book.date))
                                        .font(.caption)
                                }
                            }
                        }
                    }.onDelete(perform: deleteBook)
                }
                Group{
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Delete All") {
                            self.showDeleteAllAlert = true
                        }.padding()
                            .alert(isPresented: $showDeleteAllAlert) {
                                Alert(title: Text("Warning"), message: Text("Are you sure to delete all books?" ), primaryButton: .destructive(Text("OK")) {
                                    _ = self.books.map{self.moc.delete($0)}
                                    }, secondaryButton: .cancel())
                        }
                        Spacer()
                    }
                }
            
                
            }.navigationBarTitle(Text("BookWorm"))
                .navigationBarItems(leading: EditButton(), trailing:
                    Button(action: {self.showNewSheet = true}) {
                        Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showNewSheet){
                            AddNewBookView(
                            ).environment(\.managedObjectContext, self.moc)})
            
        }
    }
    
    func formattedDate(of date: Date?) -> String {
        if  date != nil {
            let df = DateFormatter()
            df.dateStyle = .medium
            return df.string(from: date!)
        } else {
            return ""
        }
    }
    
    // althought it's offsets, one can only delete one at once.
    func deleteBook(at offsets: IndexSet ) {
        for  offset in offsets {
            print("offsets =" + String((offset)))
            let book  = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
