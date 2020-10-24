//
//  ContentView.swift
//  instafilter
//
//  Created by T  on 2020-10-24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture{
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change Background"), message: Text("Select a new Color"), buttons: [
                    .default(Text("Red")) {self.backgroundColor = .red},
                    .default(Text("Blue")) {self.backgroundColor = .blue},
                    .default(Text("Green")) {self.backgroundColor = .green},
                    .cancel()
                            ])
                
            }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

