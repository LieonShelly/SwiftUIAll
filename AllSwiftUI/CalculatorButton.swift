//
//  CalculatorButton.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/7.
//

import Foundation
import SwiftUI

struct CalculatorButton: View {

    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
        var body: some View {
            return Button(action: action, label: {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: fontSize))
                    .frame(width: size.width, height: size.height)
                    .background(Color(backgroundColorName))
                    .cornerRadius(size.width * 0.5)
            })
        }
    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: size.width * 0.5)
//                .fill(Color(backgroundColorName))
//                .frame(width: size.width, height: size.height)
//
//            Button(action: action, label: {
//                Text(title)
//                    .foregroundColor(.white)
//                    .font(.system(size: fontSize))
//                    .frame(width: size.width, height: size.height)
//            })
//
//        }
//
//    }
}
