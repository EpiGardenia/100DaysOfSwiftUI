//
//  AddNameView.swift
//  IRemember
//
//  Created by T  on 2020-11-30.
//

import SwiftUI


struct AddNameView: View {
    @Environment(\.presentationMode) var presentationMode
    //@Binding var name: String
    @State private var name: String = ""
    let photo: UIImage?
    var body: some View {
        VStack{
            // show photo
            
            Text("Name:")
            TextField("Add Name", text: self.$name)
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {self.saveButtonClicked()}){
                Text(verbatim: "Save")
            }
        }
        
    }
    
    func saveButtonClicked(){
        // get a directory path in disk
        let path = getDocDir().appendingPathComponent("contacts.json")
        // save in struct
        do {
            //   if let jpegData = photo.jpegData(compressionQuality: 0.8) {
            let newContact = Contact(name: self.name/*, photo: jpegData*/)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            // read json file
            if FileManager.default.fileExists(atPath: path.path)
            {
                guard let diskData = try? Data(contentsOf: path) else {
                    fatalError("Failed to load data from file")
                }
                let decoder = JSONDecoder()
                if var decodedDiskData = try? decoder.decode([Contact].self, from: diskData) {
                    decodedDiskData.append(newContact)
                    if let encoded = try? encoder.encode(decodedDiskData) {
                        try encoded.write(to: path, options: [.atomicWrite, .completeFileProtection])
                    }
                }
  
            }
            else
            {
                if let encoded = try? encoder.encode([newContact]) {
                    try encoded.write(to: path, options: [.atomicWrite, .completeFileProtection])
                }
            }
            let decoder = JSONDecoder()
            guard let data = try? Data(contentsOf: path) else {
                fatalError("Failed to load data from file")
            }
            let decoded = try decoder.decode([Contact].self, from: data)
            print(decoded[0].name)
        } catch {
            print(error.localizedDescription)
        }

        // test of read
        
        
        
        // dismiss view
        presentationMode.wrappedValue.dismiss()
    }
    
    func saveToPath(path:String, content:String)
    {
        
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
