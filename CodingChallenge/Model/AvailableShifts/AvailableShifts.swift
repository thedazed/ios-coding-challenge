//
//  AvailableShifts.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import Foundation

struct AvailableShifts: Decodable {
    let data: [AvailableShiftsDay]
}

struct AvailableShiftsDay: Decodable, Identifiable {
    let id = UUID()
    let date: String
    let shifts: [Shift]
    
    enum CodingKeys: String, CodingKey {
        case date
        case shifts
    }
}

struct Shift: Decodable, Identifiable {
    var id: Int { shift_id }
    let shift_id: Int
    let normalized_start_date_time: String
    let normalized_end_date_time: String
    let premium_rate: Bool
    let covid: Bool
    let facility_type: FacilityType
    let skill: Skill
    let localized_specialty: LocalizedSpecialty
    
    func startHour() -> String {
        normalized_start_date_time[11..<16] // more optimal than using DateFormatter
    }
    
    func endHour() -> String {
        normalized_end_date_time[11..<16]
    }
}

struct Skill: Decodable {
    let name: String
    let color: String
}

struct FacilityType: Decodable {
    let name: String
    let color: String
}

struct LocalizedSpecialty: Decodable {
    let name: String
}
