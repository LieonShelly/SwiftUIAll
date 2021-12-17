//
//  AllSwiftUIApp.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/7.
//

import SwiftUI

@main
struct AllSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainTab().environmentObject(Store())
//            CaculatorContentView()
        }
    }
}
