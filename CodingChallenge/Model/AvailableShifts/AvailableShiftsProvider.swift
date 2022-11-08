//
//  AvailableShiftsProvider.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import Foundation

struct AvailableShiftsProvider {
    
    private var apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    func fetchAvailableShifts(type: DateRangeType? = nil,
                              startDate: Date? = nil,
                              endDate: Date? = nil,
                              address: String,
                              radius: Int? = nil,
                              completion: @escaping (Result<AvailableShifts, Error>) -> Void) {
        var start: String?
        if let startDate = startDate {
            start = AvailableShiftsProvider.dateFormatter.string(from: startDate)
        }
        var end: String?
        if let endDate = endDate {
            end = AvailableShiftsProvider.dateFormatter.string(from: endDate)
        }
        let params = AvailableShiftsParams(type: type, start: start, end: end, address: address, radius: radius)
        let service = AvailableShiftsService(params: params)
        
        apiClient.dataTask(with: service, completion: completion)
    }
}
