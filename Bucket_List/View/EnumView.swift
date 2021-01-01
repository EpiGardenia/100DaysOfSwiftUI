//
//  EnumView.swift
//  Bucket_List
//
//  Created by T  on 2021-01-01.
//

import SwiftUI

enum loadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading View")
    }
}


struct SuccessView: View {
    var body: some View {
        Text("Success View")
    }
}



struct FailedView: View {
    var body: some View {
        Text("Failed View")
    }
}

struct EnumView: View {
    @State private var currentLoadingState = loadingState.loading
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Button("Loading") {
                    currentLoadingState = loadingState.loading
                }.padding()
                Button("Success") {
                    currentLoadingState = loadingState.success
                }.padding()
                Button("Failed") {
                    currentLoadingState = loadingState.failed
                }.padding()
            }
            Spacer()
            switch currentLoadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
            Spacer()
        }
    }
}

struct EnumView_Previews: PreviewProvider {
    static var previews: some View {
        EnumView()
    }
}
