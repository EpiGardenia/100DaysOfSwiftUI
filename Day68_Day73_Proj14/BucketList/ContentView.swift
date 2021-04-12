//
//  ContentView.swift
//  BucketList
//
//  Created by T  on 2020-10-30.
//
import LocalAuthentication
import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var showingUnauthenticatedAlert = false
    
    var body: some View {
        ZStack{
            if isUnlocked {
                MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                    .edgesIgnoringSafeArea(.all)
                Circle.blueDot()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example Location"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }) {
                            Image(systemName: "plus")
                        }.buttonStyle(PlusButtonStyle())
                    }
                }
            } else {
                Button("Unlock Screen", action:{ self.authenticate() }).buttonStyle(UnlockButtonStyle())
            }
        }
        .alert(isPresented: $showingPlaceDetails){
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place Information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")){
                self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData){
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        }
        catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("savePlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                      //  self.showingUnauthenticatedAlert = true
                    }
                }
            }
        } else {
            // no biometry
        }
    }
    
}

public struct UnlockButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

public struct PlusButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
            .padding(.trailing)
    }
}



extension Circle {
   static func blueDot() -> some View{
        return Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
