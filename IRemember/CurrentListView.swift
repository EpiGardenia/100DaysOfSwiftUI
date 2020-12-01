////
////  CurrentListView.swift
////  IRemember
////
////  Created by T  on 2020-11-09.
////
//
//import SwiftUI
//
//struct CurrentListView: View {
//    @State var showingUploadPhoto = false
//    var body: some View {
//        NavigationView{
//            List(){
//                // go through list
//            }
//            .navigationBarTitle("Name List", displayMode: .large)
//            .navigationBarItems(leading: EditButton(),
//                                trailing: Button(action: {
//                                    self.showingUploadPhoto = true
//
//                                })
//                                { Image(systemName: "plus") })
//            .sheet(isPresented: $showingUploadPhoto) {
//                ImagePicker(, image: <#Binding<UIImage?>#>)
//            }
//        }
//    }
//
//
//}
//
//struct CurrentListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentListView()
//    }
//}
