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
        NavigationView{
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                GeometryReader{ geometry in
                    List{
                        Section{
                            self.rowLayout(title: "Age", source: self.user.age)
                            self.rowLayout(title: "Company", source: self.user.company)
                            self.rowLayout(title: "Email", source: self.user.email)
                            self.rowLayout(title: "Address", source: self.user.address)
                            self.rowLayout(title: "Registered", source: self.user.registered)
                        }
                        Section {
//
//                            Text("Tags")
//                            self.TagsView(tags: self.user.tags, geo: geometry.size.width)
                            Text("Tags")
                                .font(.title)
                                .foregroundColor(.green)
                            VStack{
                            ForEach(self.user.tags, id:\.self) { tag in
                                Text("#"+tag)
                                    .modifier(TagStyle())
                            }.lineLimit(nil)
                                .layoutPriority(1)
                            }
                        }
                        Spacer()
                        Section {
                    Text("Friends")
                        .font(.title)
                        .foregroundColor(.green)
                    ForEach(self.user.friends, id: \.self) { friend in
                        Text(friend.name)
                            .font(.callout)
                    }
                    //
                    //                ForEach(user.friends, id: \.self) { friend in
                    //
                    //                    if let friendUser = getFriendInfo(friend.id) {
                    //                         NavigationLink(friend.name, destination: UserDetailView(friendUser))
                    //                    } else {
                    //                        Text(friend.name)
                    //                    }
                    //
                    //                }
                    //
                }
                Spacer()
                }
                
            }
            .navigationBarTitle("   " + self.user.name)
            .padding(5)
            
            }
            
        }
        
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
    }
    
    
    //TODO: seperate all tags into array of tags, each array is one row. The length of tags in one row shall not exceed MaxWidth of geometry
    // Return: [[String], [String]...]
//    func splitInRows<T>(from: [T], maxWidth: CGFloat) -> [T] {
//
//    }
}


struct TagStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.blue)
            .background(Color.init(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
}





extension View {
    func rowLayout<T:LosslessStringConvertible>(title: String, source: T) -> some View {
        HStack{
            Text(title)
            Spacer()
            Text(String(source))
        }
    }
    
    func tagView(tag: String) -> some View {
        self.modifier(TagStyle())
    }
    
    
  
    
//
//    //TODO: make a func outside of view
//    // or using conditional view.
//    @ViewBuilder
//    func TagsView(tags: [String], geo: GeometryProxy) -> some View {
//        let maxWidth = geo.size.width
//        var tagsWidth = 0
//        var index = 0
//
//        HStack{
//            while(tagsWidth < maxWidth) {
//                tagsWidth += (tags[index].count+2)
//                Text(tag)
//                    .self.tagView(tag:tag)
//                index += 1
//            }
//        }
//
//    }
    
    
}



struct UserDetailView_Previews: PreviewProvider {
    
    static let users: [User] = Bundle.main.decode(from: "twoUsers.json")
    static var previews: some View {
        UserDetailView(user: users[0])
    }
}
