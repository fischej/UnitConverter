//
//  sectionRow.swift
//  UnitConverter
//
//  Created by Jeff Fischer on 7/15/22.
//

import SwiftUI

struct SectionRow: View {
    @Binding var unitValue: Double

    let unit: Unit
    let calculate: (Unit) -> Void
    let formatter: NumberFormatter

    var body: some View {
        HStack {
            Text(unit.rawValue)
                .frame(width: 100, alignment: .leading)
            TextField(unit.rawValue, value: $unitValue, formatter: formatter, onEditingChanged: { stillTyping in
                if !stillTyping { calculate(unit) }
            })
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
