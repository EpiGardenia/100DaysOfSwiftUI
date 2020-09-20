//
//  ContentView.swift
//  FriendFace
//
//  Created by T  on 2020-09-16.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        
        NavigationView {
            List(self.getUsers(), id:\.self) { user in
                NavigationLink(user.name, destination: UserDetailView(user: user))
                
            }
        }
        
    }
    
    
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
