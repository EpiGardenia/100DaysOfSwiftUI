//
//  ContentView.swift
//  FriendFace
//
//  Created by T  on 2020-09-16.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showNavigationLink:Bool = false
    var body: some View {
        
        NavigationView {
            List(self.getUsers(), id:\.self) { user in
                NavigationLink(destination: UserDetailView(user: user)){
                        Text(user.name)
                    }
            }.navigationBarTitle(Text("Friend List"))
        }}
    
    
    func getUsers() -> [User] {
        guard let data = try? Data(contentsOf: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!) else {
            fatalError()
        }

        let jDecoder = JSONDecoder()
        guard let parsedData = try? jDecoder.decode([User].self, from: data) else {
            fatalError()
        }
           
        return parsedData
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
