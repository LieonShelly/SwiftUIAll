//
//  store.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation

class Store: ObservableObject {
    @Published var appState = AppState()
    
    static func reduce(state: AppState, action: AppAction) -> AppState {
        var appState = state
        switch action {
        case .login(let email, let password):
            if password == "passwrod" {
                let user = User(email: email, favoritePokemonIDs: [])
                appState.settings.loginUser = user
            }
        }
        return appState
    }
    
    func dispatch(_ action: AppAction) {
        let result = Store.reduce(state: appState, action: action)
        appState = result
    }
}
