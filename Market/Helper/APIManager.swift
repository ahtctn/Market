//
//  APIClient.swift
//  Market
//
//  Created by Ahmet Ali ÇETİN on 27.03.2023.
//

import UIKit

enum NetworkError: Error {
    case invalidDataError
    case invalidResponseError
    case urlError
    case decodingError(_ error: Error)
}

typealias Handler = (Result<[ProductModel], NetworkError>) -> Void

///Singleton Design Pattern
class APIManager {
    static let shared = APIManager()
    private init() {
        
    }
    
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.url) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        ///BACKGROUND TASK 
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.invalidDataError))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(NetworkError.invalidResponseError))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let products = try jsonDecoder.decode([ProductModel].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(NetworkError.decodingError(error )))
            }
            
        }.resume()
    }
}
