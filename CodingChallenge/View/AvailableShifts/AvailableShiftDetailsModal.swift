//
//  AvailableShiftDetailsModal.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import SwiftUI

struct AvailableShiftDetailsModal: View {
    
    @Binding var shift: Shift?
    
    var body: some View {
        if let shift = shift {
            ZStack {
                Blur(style: .dark)
                    .onTapGesture(perform: {
                        self.shift = nil
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                HStack {
                    Spacer().frame(width: 10)
                    VStack {
                        Group {
                            Text(shift.localized_specialty.name)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Eligible skill: " + shift.skill.name)
                            Text("Facility: " + shift.facility_type.name)
                            Text("Start time: " + shift.normalized_start_date_time)
                            Text("End time: " + shift.normalized_end_date_time)
                            Text("Covid: \(shift.covid ? "Yes" : "No")")
                            Text("Premium rate: \(shift.premium_rate ? "Yes" : "No")")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(colorFromHex(shift.skill.color), lineWidth: 3)
                    )
                    .background(.white)
                    .cornerRadius(16)
                    Spacer().frame(width: 10)
                }
            }
        }
    }
}
