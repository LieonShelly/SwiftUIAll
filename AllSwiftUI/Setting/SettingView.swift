//
//  SettingView.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/13.
//

import Foundation
import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView().navigationTitle("设置")
        }
    }
}

struct SettingView: View {
    
    @ObservedObject
    var settings = Settings()
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
        
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            Picker(
                selection: $settings.accountBehavior,
                label: Text(""))
            {
                ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("电子邮箱", text: $settings.email)
            SecureField("密码", text: $settings.password)
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: $settings.verifyPassword)
            }
            Button(settings.accountBehavior.text) {
                print("登录/注册")
            }
        }
    }
    
    var optionSection: some View {
        Section {
            Toggle("显示英文名", isOn: $settings.showEnglishName)
            HStack {
                Text("排序方式")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Button("ID >") {
                    
                }
                .foregroundColor(.gray)
                
            }
            
            Toggle("只显示收藏", isOn: $settings.showFavoriteOnly)
        }
    }
    
    var actionSection: some View {
        Button("清空缓存") {
        }
        .font(.subheadline)
        .foregroundColor(.red)
    }
}
