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
        NavigationView {
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
                            Text("Tags")
                                .font(.title)
                                .foregroundColor(.green)
//                            self.user.tags.chunked(into: 4).map{
//                                HStack{
//                                    ForEach($0, id: \.self) { k in
//                                        Text("#" + String(k))                          .modifier(TagStyle(screenWidth: geometry.size.width))
//                                    }
//                                }
//                            }
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
                        }
                        
                    }
                }
            }
            .navigationBarTitle("   " + self.user.name)
            .padding(5)
        } //End of NavigationView
    }  // End of body View
    
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
    let screenWidth: CGFloat
    func body(content: Content) -> some View {
        content
            //  .font(.caption)
            .foregroundColor(.blue)
            .background(Color.init(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(width: screenWidth/4)
    }
} // end of TagStyle
    
    extension View {
        func rowLayout<T:LosslessStringConvertible>(title: String, source: T) -> some View {
            HStack{
                Text(title)
                Spacer()
                Text(String(source))
            }
        }
        
        func tagView(tag: String, width: CGFloat) -> some View {
            self.modifier(TagStyle(screenWidth: width ))
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
