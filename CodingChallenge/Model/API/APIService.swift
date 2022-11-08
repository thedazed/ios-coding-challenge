//
//  APIService.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import Foundation

protocol APIService {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    associatedtype ReturnType: Decodable
}
