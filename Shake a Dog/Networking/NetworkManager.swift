//
//  NetworkManager.swift
//  Shake a Dog
//
//  Created by Adolpho Piazza on 29/04/21.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() {}
    
    func fetch(imageURLHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Something went wrong: \(error)")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(DogModel.self, from: data ?? Data())
                imageURLHandler(decoded.message)
            } catch let err {
                print("We got some errors on try-catch block: \(err)")
            }
            
        }.resume()
    }
    
}
