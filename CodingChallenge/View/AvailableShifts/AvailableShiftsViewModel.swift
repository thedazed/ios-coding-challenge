//
//  AvailableShiftsViewModel.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import Foundation

@MainActor class AvailableShiftsViewModel: ObservableObject {
    
    @Published var shiftDays = [AvailableShiftsDay]()
    @Published var fetchedAll = false
    private var weeksForward = 0
    
    func fetchNextShiftsWeek(address: String, radius: Int) {
        let startDate = Calendar.current.date(byAdding: .weekOfYear, value: weeksForward, to: Date())
        let provider = AvailableShiftsProvider(apiClient: DefaultAPIClient())
        provider.fetchAvailableShifts(type: .week,
                                      startDate: startDate,
                                      address: "Dallas, TX",
                                      radius: 10) { result in
            switch result {
            case .success(let shifts):
                let daysWithShifts = shifts.data.filter({ !$0.shifts.isEmpty })
                if daysWithShifts.isEmpty {
                    // simplified, if specified downloaded week has 0 shifts, I assume we reached end
                    self.fetchedAll = true
                } else {
                    self.weeksForward += 1
                    self.shiftDays.append(contentsOf: daysWithShifts)
                }
            case .failure(let error):
                print("error: \(error)") // not handled
                // TODO: present error, handle paging error
            }
        }
    }
}
