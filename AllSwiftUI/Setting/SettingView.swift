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
    
    @EnvironmentObject var store: Store
    
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    var setting: AppState.Settings {
        store.appState.settings
    }
    
    var body: some View {
        Form {
            Section(header: Text("账户")) {
                if setting.loginUser == nil {
                    Button(setting.accountBehavior.text) {
                        self.store.dispatch(
                            .login(
                                email: self.setting.email,
                                password: self.setting.password
                            )
                        )
                    }
                } else{
                    Text(setting.loginUser!.email)
                    Button("注销") {
                        print("注销")
                    }
                }
            }
            accountSection
            optionSection
            actionSection
        }
        
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            Picker(
                selection: settingsBinding.accountBehavior,
                label: Text(""))
            {
                ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            if store.appState.settings.accountBehavior == .register {
                SecureField("确认密码", text: settingsBinding.verifyPassword)
            }
            Button(store.appState.settings.accountBehavior.text) {
                print("登录/注册")
            }
        }
    }
    
    var optionSection: some View {
        Section {
            Toggle(isOn: settingsBinding.showEnglishName) {
                Text("显示英文名")
            }
            Picker(selection: settingsBinding.sorting, label: Text("排序方式")) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            Toggle(isOn: settingsBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
            
        }
    }
    
    var actionSection: some View {
        Button("清空缓存") {
        }
        .font(.subheadline)
        .foregroundColor(.red)
    }
}


extension AppState.Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}
