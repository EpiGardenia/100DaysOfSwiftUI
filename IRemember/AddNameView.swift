//
//  AddNameView.swift
//  IRemember
//
//  Created by T  on 2020-11-30.
//

import SwiftUI


struct AddNameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    let photo: UIImage?
    var body: some View {
        VStack{
            Text("Name:")
            TextField("Add Name", text: self.$name)
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {self.saveButtonClicked()}){
                Text(verbatim: "Save")
            }
        }.onAppear(){
            if photo == nil {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func saveButtonClicked(){
        // Save contact in json file
        let path = getDocDir().appendingPathComponent("contacts.json")
        if let jpegPhoto = self.photo!.jpegData(compressionQuality: 0.8) {
            let newContact = Contact(name: self.name, photo: jpegPhoto)
            appendContactToFile(newContact: newContact, filePath: path)
        } else {
            print("Failed to compress image")
        }

        // dismiss view
        presentationMode.wrappedValue.dismiss()
    }
    
    func getDocDir() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }    
}

struct AddNameView_Previews: PreviewProvider {

    static var previews: some View {
        Text("hello")
      //  AddNameView(name: self.$nameString)
    }
}
