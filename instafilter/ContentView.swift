//
//  ContentView.swift
//  instafilter
//
//  Created by T  on 2020-10-24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image:Image?
    @State private var filterTitle = "Choose Filter"
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var showingImageFilter = false
    @State private var showingNoImageAlert = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    var body: some View {
        let intensity = Binding<Double> (
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
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
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button(self.filterTitle){
                      showingImageFilter = true
                    }
                    Spacer()
                    Button("Save"){
                        guard let processedImage = self.processedImage else {
                            showingNoImageAlert = true
                            return }
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $showingNoImageAlert) {
                Alert(title: Text("No Image to Save"), dismissButton: .default(Text("OK")))
            }
            .actionSheet(isPresented: $showingImageFilter) {
                ActionSheet(title: Text("Select a filter") , buttons:[
                    .default(Text("Crystalize")) {
                        self.setFilter(filter: CIFilter.crystallize())
                        filterTitle = "Crystalize"
                    },
                    .default(Text("Gausian Blur")) {
                        self.setFilter(filter: CIFilter.gaussianBlur())
                        filterTitle = "Gausian Blur"
                    },
                    .default(Text("False Color")) {
                        self.setFilter(filter: CIFilter.falseColor())
                        filterTitle = "False Color"
                    },
                    .default(Text("Bump Distortion Linear")) {
                        self.setFilter(filter: CIFilter.bumpDistortionLinear())
                        filterTitle = "Bump Distortion Linear"
                    },
                    .cancel()
                        ])
            }
        }
    }
    
    func setFilter(filter: CIFilter) {
        self.currentFilter = filter
        loadImage()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity*10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity*200, forKey: kCIInputRadiusKey)
        }
      
        guard let outputImage = currentFilter.outputImage
        else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

