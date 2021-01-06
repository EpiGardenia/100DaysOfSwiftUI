//
//  MeView.swift
//  Hot_Prospects
//
//  Created by T  on 2021-01-05.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct MeView: View {
    @State private var name = ""
    @State private var email = ""
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack {
            Spacer()
            TextField("Name", text: $name)
                .textContentType(.name)
                .font(.title)
                .padding(.horizontal)
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .font(.title)
                .padding([.horizontal, .bottom])
            Spacer()
            Image(uiImage: generateQRCode(from: "\(name)\n\(email)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height:200)
                .padding()
            Spacer()
            
        }.navigationTitle("Your QR Code")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage {
            if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
