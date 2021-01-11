//
//  FriendsView.swift
//  FriendFace
//
//  Created by T  on 2020-09-20.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct FriendsView: View {
    let friends: [Friend]
    var body: some View {
        VStack{
            List(friends, id: \.self) { friend in
                self.getFriendDetails(friend: friend, of: self.getUsers()).map{
                    NavigationLink(destination: UserDetailView (user: $0)) {
                        Text(friend.wrappedName)
                    }.isDetailLink(false)
                }
            }
        }
    }
    
    
    func getFriendDetails(friend: Friend, of list: [User]) -> User? {
        if let user = list.first(where: {($0.id == friend.id) && ($0.name == friend.name)}) {
            return user
        }
        return nil
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

struct FriendsView_Previews: PreviewProvider {
    static let users: [User] = Bundle.main.decode(from: "twoUsers.json")
    static var previews: some View {
        FriendsView(friends: users[1].friendArray)
    }
}
