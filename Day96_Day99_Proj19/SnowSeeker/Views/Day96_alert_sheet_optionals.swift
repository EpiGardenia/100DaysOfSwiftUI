//
//  Day96_alert_sheet_optionals.swift
//  SnowSeeker
//
//  Created by T  on 2021-01-20.
//

import SwiftUI


struct User: Identifiable{
    var id = "Taylor Swift"
}

struct Day96_alert_sheet_optionals: View {
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                self.selectedUser = User()
            }
            // When alert is dismiss, User = nil again
            .alert(item: $selectedUser,
                   content: { user in Alert(title: Text(user.id))})
        
    }
}

struct Day96_alert_sheet_optionals_Previews: PreviewProvider {
    static var previews: some View {
        Day96_alert_sheet_optionals()
    }
}
