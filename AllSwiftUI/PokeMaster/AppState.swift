//
//  AppState.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation

struct AppState {
    var settings = Settings()
    
}


extension AppState {
    
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        var loginUser: User? = nil
        
    }
}


extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}
