//
//  APIClient.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import Foundation

protocol APIClient {
    func dataTask<ReturnType: Decodable>(with request: URLRequest,
                                                completion: @escaping (Result<ReturnType, Error>) -> Void)
    func dataTask<T: APIService>(with service: T, completion: @escaping (Result<T.ReturnType, Error>) -> Void)
}

struct DefaultAPIClient: APIClient {

    func dataTask<ReturnType: Decodable>(with request: URLRequest,
                                                completion: @escaping (Result<ReturnType, Error>) -> Void) {
        let task = URLSession.testApp.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode),
                      let data = data {
                do {
                    let shifts = try JSON.decoder.decode(ReturnType.self, from: data)
                    completion(.success(shifts))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIClientError.invalidResponse))
            }
        }
        task.resume()
    }
    
    func dataTask<T: APIService>(with service: T, completion: @escaping (Result<T.ReturnType, Error>) -> Void) {
        guard let url = APIAddress.apiURL.appendingPathComponent(service.path).appendingQueryItems(service.queryItems) else {
            completion(.failure(APIClientError.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = service.httpMethod.rawValue
        request.allHTTPHeaderFields = service.headers
        dataTask(with: request, completion: completion)
        
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

enum APIClientError: Error {
    case badURL
    case invalidResponse
}

extension URLSession {
    static let testApp = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
}
