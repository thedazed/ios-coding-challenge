//
//  AvailableShiftsService.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import Foundation

struct AvailableShiftsService: APIService {
    typealias ReturnType = AvailableShifts
    
    var path: String = "available_shifts"
    var queryItems: [URLQueryItem]
    var httpMethod: HTTPMethod = .get
    var headers: [String : String] = ["Content-Type" : "application/json",
                                      "Accept" : "application/json"]
    
    init(params: AvailableShiftsParams) {
        self.queryItems = params.queryItems
    }
}

struct AvailableShiftsParams {
    let type: DateRangeType?
    let start: String?
    let end: String?
    let address: String
    let radius: Int?
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "address", value: address))
        if let type = type { items.append(URLQueryItem(name: "type", value: type.rawValue)) }
        if let start = start { items.append(URLQueryItem(name: "start", value: start)) }
        if let end = end { items.append(URLQueryItem(name: "end", value: end)) }
        if let radius = radius { items.append(URLQueryItem(name: "radius", value: "\(radius)")) }
        return items
    }
}

enum DateRangeType: String {
    case week = "week"
    case fourDay = "4day"
    case list = "list"
}
