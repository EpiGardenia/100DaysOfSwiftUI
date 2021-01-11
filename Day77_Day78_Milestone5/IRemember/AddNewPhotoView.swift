//
//  AddNewPersonView.swift
//  IRemember
//
//  Created by T  on 2020-11-21.
//

import SwiftUI

struct AddNewPhotoView: View {
    @State private var image: Image?
    @Binding var shownImage: UIImage?
    var body: some View {
            VStack{
                if let image = image{
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Rectangle()
                        .foregroundColor(.gray)
                        .scaledToFit()
                }
                Text("AddNewPhotoView")
//                ImagePicker(image: $shownImage)
//                {
//                    loadImage()
//                }
            }.navigationBarItems(trailing: Button("Next"){})
    }
    
    func loadImage() {
        guard let shownImage = shownImage else { return }
        image = Image(uiImage: shownImage)
    }
}

struct AddNewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello world")
    }
}
