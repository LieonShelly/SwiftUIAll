//
//  CalculatorButtonRow.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/7.
//

import Foundation
import SwiftUI

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
//    @Binding var brain: CalculatorBrain
    var model: CalculatorModel
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName)
                {
                    print(item.title)
                    self.model.apply(item)
                }
            }
        }
    }
}
