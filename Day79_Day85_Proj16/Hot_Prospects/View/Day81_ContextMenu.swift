//
//  Day81_ContextMenu.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-04.
//

import SwiftUI

struct Day81_ContextMenu: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack{
            Text("Hello World!")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .contextMenu(menuItems: {
                    Button(action: {
                            self.backgroundColor = .red}
                           , label: {
                            Text("Red")
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                           })
                    
                    Button(action: {
                                self.backgroundColor = .green}
                               , label: {
                            Text("Green")
                        })
                    Button(action: {
                            self.backgroundColor = .blue}
                           , label: {
                        Text("Blue")
                    })
                })
                .foregroundColor(backgroundColor)
                
        }
    }
}

struct Day81_ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        Day81_ContextMenu()
    }
}
