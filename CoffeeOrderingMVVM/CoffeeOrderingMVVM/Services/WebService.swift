//
//  WebService.swift
//  CoffeeOrderingMVVM
//
//  Created by Alperen Selçuk on 27.03.2022.
//  Copyright © 2022 Alperen Selçuk. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "Get"
    case post = "Post"
}

struct Resource<T: Codable> {
    let url: URL

    var httpMethot: HttpMethod = .get
    var body: Data? = nil
}


extension Resource {
    init(url: URL) {
        self.url = url
    }
}

class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethot.rawValue
        request.httpBody = resource.body
        request.addValue("applicaton/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
           
//            print(T.self)
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
