//
//  AddNameView.swift
//  IRemember
//
//  Created by T  on 2020-11-30.
//

import SwiftUI

struct AddNameView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String
    var body: some View {
        VStack{
            Text("Name:")
            TextField("Add Name", text: self.$name)
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {presentationMode.wrappedValue.dismiss()}){
                Text(verbatim: "Confirm")
            }
        }
        
    }
    
}

struct AddNameView_Previews: PreviewProvider {

    static var previews: some View {
        Text("hello")
      //  AddNameView(name: self.$nameString)
    }
}
