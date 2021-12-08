//
//  CalculatorButtonPad.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/7.
//

import Foundation
import SwiftUI

struct CalculatorButtonPad: View {
//    @Binding var brain: CalculatorBrain
    var model: CalculatorModel
    
    let pad: [[CalculatorButtonItem]] = [ [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
                                          [.digit(7), .digit(8), .digit(9), .op(.multiply)],
                                          [.digit(4), .digit(5), .digit(6), .op(.minus)],
                                          [.digit(1), .digit(2), .digit(3), .op(.plus)],
                                          [.digit(0), .dot, .op(.equal)]
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self, content: { row in
                CalculatorButtonRow(row: row, model: self.model)
            })
        }
    }
}

@propertyWrapper
struct Converter {
    let from: String
    let to: String
    let rate: Double
    var value: Double
    
    var wrappedValue: String {
        get { "\(from) \(value)" }
        set { value = Double(newValue) ?? -1 }
    }
    
    var projectedValue: String {
        return "\(to) \(value * rate)"
    }
    
    init(
        initialValue: String,
        from: String,
        to: String,
        rate: Double
    ) {
        self.rate = rate
        self.value = 0
        self.from = from
        self.to = to
        self.wrappedValue = initialValue
    }
}


