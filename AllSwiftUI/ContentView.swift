//
//  ContentView.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/7.
//

import SwiftUI

struct ContentView: View {
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    //    @State private var brain: CalculatorBrain = .left("0")
    @ObservedObject var model = CalculatorModel()
    @State private var editingHistory = false
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer() // 把屏幕占满
            Text(model.brain.output)
                .font(.system(size: 76))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            Button("操作履历: \(model.history.count)") {
                self.editingHistory = true
            }.sheet(isPresented: $editingHistory) {
                HistoryView(model: self.model)
            }
            CalculatorButtonPad(model: self.model)
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



struct HistoryView: View {
    @ObservedObject var model: CalculatorModel
    
    var body: some View {
        VStack {
            if model.totalCount == 0 {
                Text("没有履历")
            } else {
                HStack {
                    Text("履历").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
            }
        }.padding()
    }
}
