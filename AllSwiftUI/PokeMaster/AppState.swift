//
//  AppState.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation
import Combine
import SwiftUI

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
        @State var email = ""
        @State var password = ""
        var verifyPassword = ""
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
        var loginRequesting = false
        var loginError: AppError?
        //        var checker = AccountChecker()
        var isEmailValid: Bool = false
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            //            var isEmailValid: AnyPublisher<Bool, Never> {
            //                let remoteVerify = $email.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            //                    .removeDuplicates()
            //                    .flatMap { email -> AnyPublisher<Bool, Never> in
            //                        let validEmail = email.isValidEmailAddress
            //                        let canSkip = self.accountBehavior == .login
            //                        switch (validEmail, canSkip) {
            //                        case (false, _):
            //                            return Just(false).eraseToAnyPublisher()
            //                        case (true, false):
            //                            return Ema
            //                        }
            //                    }
            //            }
        }
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
