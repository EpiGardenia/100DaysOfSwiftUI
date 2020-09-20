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
        List{
            ForEach(friends, id: \.self) { friend in
                Text(friend.name)
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
      static let users: [User] = Bundle.main.decode(from: "twoUsers.json")
    static var previews: some View {
        FriendsView(friends: users[1].friends)
    }
}
