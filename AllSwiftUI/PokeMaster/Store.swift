//
//  store.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.settings.checker.isEmailValid
            .sink { isValid in
                self.dispatch(.emailValid(valid: isValid))
            }
            .store(in: &disposeBag)
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        switch action {
        case .login(let email, let password):
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .accountBehaviorDone(result: let result):
            appState.settings.loginRequesting = false
            appState.settings.registerRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        case .logout:
            appState.settings.loginUser = nil
        case .emailValid(valid: let valid):
            appState.settings.isEmailValid = valid
        case .loadPokemons:
            if appState.pokemonList.loadingPokemons {
                break
            }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(result: let result):
            switch result {
            case .success(let models):
                appState.pokemonList.pokemons = Dictionary(
                    uniqueKeysWithValues: models.map { ($0.id, $0)}
                )
            case .failure(let error):
                print(error)
            }
        case .register(email: let email, password: let password, verifyPassword: let verifyPassword):
            guard !appState.settings.registerRequesting else  {
                break
            }
            appState.settings.registerRequesting = true
            appCommand = RegisterCommand(email: email, password: password, verifyPassword: verifyPassword)
        }
        return (appState, appCommand)
    }
    
    func dispatch(_ action: AppAction) {
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            command.execute(in: self)
        }
    }
}
