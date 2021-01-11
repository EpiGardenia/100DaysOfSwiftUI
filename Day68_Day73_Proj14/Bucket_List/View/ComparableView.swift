//
//  ComparableView.swift
//  Bucket_List
//
//  Created by T  on 2021-01-01.
//

import SwiftUI

struct ComparableView: View {
    let nameList = [
        User(firstName: "Anna", lastName: "Sui"),
        User(firstName: "Water", lastName: "Melon"),
        User(firstName: "Mango", lastName: "Ice")
    ].sorted()
    
    var body: some View {
        List(nameList, id:\.id){ user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ComparableView_Previews: PreviewProvider {
    static var previews: some View {
        ComparableView()
    }
}
