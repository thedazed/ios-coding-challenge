//
//  AvailableShiftCell.swift
//  CodingChallenge
//
//  Created by Karol Magier on 06/11/2022.
//

import SwiftUI

struct AvailableShiftCell: View {
    
    let shift: Shift
    
    var body: some View {
        VStack {
            Group {
                Text(shift.localized_specialty.name)
                    .fontWeight(Font.Weight.bold)
                Text(shift.skill.name)
                Text(shift.facility_type.name)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("\(shift.startHour()) - \(shift.endHour())")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(colorFromHex(shift.skill.color), lineWidth: 3)
        )
        .listRowSeparator(.hidden)
    }
}
