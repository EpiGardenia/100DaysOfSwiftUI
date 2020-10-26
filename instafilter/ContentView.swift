//
//  ContentView.swift
//  instafilter
//
//  Created by T  on 2020-10-24.
//


import SwiftUI

struct ContentView: View {
    @State private var image:Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                        
                    // display the image
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                            
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: self.$filterIntensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter"){
                        // change filter
                        
                    }
                    Spacer()
                    Button("Save"){
                        // save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }

    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

