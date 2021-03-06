//
//  UserDetailView.swift
//  FriendFace
//
//  Created by T  on 2020-09-17.
//  Copyright © 2020 AlaacLux. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            GeometryReader{ geometry in
                List{
                    Section{
                        self.rowLayout(title: "Age", source: self.user.age)
                        self.rowLayout(title: "Company", source: self.user.wrappedCompany)
                        self.rowLayout(title: "Email", source: self.user.wrappedEmail)
                        self.rowLayout(title: "Address", source: self.user.wrappedAddress)
                    }
                    Section{
                        self.rowLayout(title: "Registered", source: self.dateFormatted(date: self.user.wrappedRegistered))
                    }
                    
                    Section {
                        NavigationLink(destination: TagView(show: self.user.tagArray)) {
                            Text("Tags")
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: FriendsView(friends: self.user.friendArray)) {
                            Text("Friends").foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("   " + self.user.wrappedName)
        .padding(5)
    }  // End of body View
    
    func dateFormatted(date: String) -> String {
        let df = ISO8601DateFormatter()
        df.formatOptions = .withInternetDateTime
        let standardDate = df.date(from: date)
        let dfNew = DateFormatter()
        dfNew.timeStyle = .short
        dfNew.dateStyle = .medium
        return dfNew.string(from: standardDate!)
    }
    
    func getFriendInfo(id: String) -> User? {
        guard let data = try? Data(contentsOf: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!) else {
            fatalError()
        }
        
        let jDecoder = JSONDecoder()
        guard let parsedData = try? jDecoder.decode([User].self, from: data) else {
            fatalError()
        }
        
        if let user = parsedData.first(where: {$0.id == id}) {
            return user
        } else {
            return nil
        }
    } // end of getFriendInfo
} // End of DetailView



/***************/
struct TagStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            // .background(Color.init(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
} // end of TagStyle

extension View {
    func rowLayout<T:LosslessStringConvertible>(title: String, source: T) -> some View {
        HStack{
            Text(title)
            Spacer()
            Spacer()
            Text(String(source))
                .foregroundColor(.gray)
        }
    }
    
    func tagView(tag: String) -> some View {
        self.modifier(TagStyle())
    }
}



extension Array{
    func chunked (into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    
    static let users: [User] = Bundle.main.decode(from: "twoUsers.json")
    static var previews: some View {
        UserDetailView(user: users[0])
    }
}
