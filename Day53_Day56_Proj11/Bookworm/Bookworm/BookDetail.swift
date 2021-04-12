//
//  bookDetail.swift
//  Bookworm
//
//  Created by T  on 2020-08-23.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import CoreData
import SwiftUI

struct BookDetail: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var pm
    
    let book: Book
    @State private var showingDeleteAlert = false

    var body: some View {
        GeometryReader{ geometry in
            VStack {
                ZStack(alignment: .bottomTrailing){
                    Image(self.book.genre ?? "Unknown")
                        .resizable()
                        .frame(width: geometry.self.size.width, height: geometry.self.size.height * 0.35)

                    Text(self.book.genre?.uppercased() ?? "Unknown")
                        .font(.caption)
                        .fontWeight(.black)
                            .padding(7)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .opacity(0.75)
                        .clipShape(Capsule())
                        .offset(x: -10, y: -10)
                }

                 
                Text(self.book.author ?? "Unknown")
                    .font(.headline)
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                    .padding()
                
                Text(self.book.review ?? "")
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle(Text(self.book.title ?? "Unknown"), displayMode: .inline)
                
            .alert(isPresented: self.$showingDeleteAlert) {
                Alert(title: Text("Delete?"), message: Text("Are you sure to delete book?"), primaryButton: .destructive(Text("Delete")) { self.deleteBook() }, secondaryButton: .cancel())
            }
        
            .navigationBarItems(trailing: Button(action: {self.showingDeleteAlert = true}) {
                Image(systemName: "trash")
            })
            
        }
    }

    func deleteBook() {
        self.moc.delete(book)
        pm.wrappedValue.dismiss()
    }
}

struct BookDetail_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let newBook = Book(context: moc)
        newBook.genre = nil
        newBook.title = "The Secret"
        newBook.rating = 4
        newBook.author = "R. L."
        newBook.review = "I like it!"
        
        
        return NavigationView {
            BookDetail(book: newBook)}
    }
}
