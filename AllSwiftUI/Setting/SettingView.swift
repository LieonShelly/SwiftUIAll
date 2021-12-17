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
            accountSection
            optionSection
            actionSection
        }
        .alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
        
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if setting.loginUser == nil {
                Picker(
                    selection: settingsBinding.accountBehavior,
                    label: Text(""))
                {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(setting.isEmailValid ? .green : .red)
                SecureField("密码", text: settingsBinding.checker.password)
                if setting.loginRequesting {
                    Text("登录中...")
                } else {
                    Button(setting.accountBehavior.text) {
                        self.store.dispatch(
                            .login(email: self.setting.checker.email, password: self.setting.checker.password)
                        )
                    }
                }
            } else {
                Text(setting.loginUser!.email)
                Button("注销") {
                    self.store.dispatch(.logout)
                }
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
