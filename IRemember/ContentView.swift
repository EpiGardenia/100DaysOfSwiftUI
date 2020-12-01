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
    @State private var showGreeting = false
    @State private var name=""
    
    var body: some View {
        NavigationView {
            VStack{
                //Current List view
                // TODO: Namelist loaded from core data
                Text("Hello")
                
            }.navigationBarTitle("I Remember!", displayMode: .large)
            .navigationBarItems(trailing: Button(action:{
                                                    self.showingImagePicker = true}) {
                                    Image(systemName: "plus")}
                                    .sheet(isPresented: $showingImagePicker, onDismiss: { askingName = true } ) {
                                        ImagePicker(image: self.$pickedImage)
                                    })
            .sheet(isPresented: self.$askingName, onDismiss: {self.showGreeting = true}){
                AddNameView(name: self.$name)
            }
            .alert(isPresented: self.$showGreeting) {
                Alert(title: Text("Greeting"), message: Text("Hi! \(self.name)"), primaryButton: .default(Text("Hi!")), secondaryButton: Alert.Button.cancel())
            }
            
        }// end of NavigationView
    } // end of body:view
    
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
