//
//  AvailableShiftsView.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI

struct AvailableShiftsView: View {
    
    @StateObject private var viewModel = AvailableShiftsViewModel()
    @State private var tappedShift: Shift? = nil
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.shiftDays) { day in
                        Section {
                            Text(day.date)
                                .font(.title2)
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                            ForEach(day.shifts) { shift in
                                AvailableShiftCell(shift: shift)
                                    .onTapGesture { self.tappedShift = shift }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    if !viewModel.fetchedAll {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowSeparator(.hidden)
                            .onAppear() { viewModel.fetchNextShiftsWeek(address: "Dallas, TX", radius: 10) }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Shifts")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            AvailableShiftDetailsModal(shift: $tappedShift)
        }
    }
}
