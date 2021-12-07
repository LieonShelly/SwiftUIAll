//
//  ContentView.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/7.
//

import SwiftUI

/**
 # view modifier 分为两种类别:
 -  像是 font，foregroundColor 这样定义在具体类型 (比如例中的 Text) 上，然 后返回同样类型 (Text) 的原地 modifier。
 - 像是 padding，background 这样定义在 View extension 中，将原来的 View 进行包装并返回新的 View 的封装类 modifier。
 
 */

struct ContentView: View {
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer() // 把屏幕占满
            Text("0")
                .font(.system(size: 76))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad()
        }
        .scaleEffect(scale)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView().previewDevice("iPhone SE (2nd generation)")
        }
    }
}



