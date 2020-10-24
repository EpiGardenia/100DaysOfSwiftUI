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
    @State private var image: Image?
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Alp")
        else {return}
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else {return}
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x:inputImage.size.width/2, y: inputImage.size.height/2), forKey: kCIInputCenterKey)
        //currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage
        else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
        
        
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

