//
//  ContentView.swift
//  IRemember
//
//  Created by T  on 2020-11-09.
//

import SwiftUI

struct ContentView: View {
    // @State var showingImagePicker = false
    @State private var pickedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var askingName = false
    @State private var savingData = false
    @State private var name=""
    @State private var contacts = [Contact]()
    
    init() {
        loadJsonData()
        print(contacts)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List(contacts.sorted()){ contact in
                        //let contactImage = Image(uiImage: UIImage(data: contact.photo) ?? UIImage(systemName: "swift")!)
                        NavigationLink(destination: ContactView(name: contact.name/*, photo: contactImage*/)) {
                            Text(contact.name)
                        }
                    }
                Button("Clear all data"){
                    clearData()
                }
                
            }.navigationBarTitle("I Remember!", displayMode: .large)
            .navigationBarItems(trailing: Button(action:{self.showingImagePicker = true}) {
                Image(systemName: "plus")
            }.sheet(isPresented: $showingImagePicker, onDismiss: { askingName = true } ) {
                ImagePicker(image: self.$pickedImage)
            })
            .sheet(isPresented: self.$askingName, onDismiss: {loadJsonData()}){
                //  if let chosen = self.pickedImage {
                AddNameView(photo: self.pickedImage)
                //  }
            }
            .onAppear(){
                loadJsonData()
            }
        }// end of NavigationView
    } // end of body:view

    func clearData() {
        try? FileManager.default.removeItem(atPath: getContactPath().path)
    }
    
    func loadJsonData() {
        contacts = getDataFromJSONFile(path: getContactPath())
        print(contacts)
    }
    
    func readJsonData() -> [Contact] {
        let path = getContactPath()
        let contacts = getDataFromJSONFile(path: path)
        return contacts
    }
    
    func getContactPath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fullPath = path[0].appendingPathComponent("contacts.json")
        print(fullPath)
        return fullPath
    }
    
}//end of View



struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            .padding()
            .foregroundColor(.black)
            .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(50)
            .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        Text("ContentView")
    }
}
