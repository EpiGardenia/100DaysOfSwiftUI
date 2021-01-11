//
//  ResultType.swift
//  Bucket_List
//
//  Created by T  on 2021-01-03.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unKnown
}


struct ResultType: View {
    let webAddress = "http://www.apple.com"
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                self.fetchData(from: webAddress) { result in
                    switch result{
                    case .success(let str):
                        print(str)
                    case .failure(.badURL): //illegal char or empty string
                        print("Bad URL")
                    case .failure(.requestFailed):
                        print("Request failed")
                    case .failure(.unKnown):
                        print("Unknown Error")
                    }
                }
            }
    }

    func fetchData(from website: String, completion:  @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: website) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(data: data, encoding: .utf8)!
                    completion(.success(stringData))
                    return
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unKnown))
                }
            }
        }.resume()
    }

}



struct ResultType_Previews: PreviewProvider {
    static var previews: some View {
        ResultType()
    }
}
