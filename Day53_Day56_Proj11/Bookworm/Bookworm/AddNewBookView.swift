//
//  AddNewBookView.swift
//  Bookworm
//
//  Created by T  on 2020-08-22.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI


struct AddNewBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var author = ""
    @State var genre: String?
    @State var rating = 3
    @State var review = ""
    private let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Book Name", text: $title )
                    TextField("Author's Name", text: $author)
                    Picker(selection: $genre, label: Text("Genre")) {
                        ForEach(genres, id: \.self) {
                            Text($0).tag($0 as String?)
                        }
                    }
                }
                
                Section{
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.author = self.author
                        newBook.title = self.title
                        newBook.rating = Int16(self.rating)
                        newBook.review = self.review
                        newBook.genre = self.genre
                        newBook.id = UUID()
                        newBook.date = Date()
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }.navigationBarTitle("Add Book")
            
        }
        
    }
}

struct AddNewBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBookView()
    }
}
