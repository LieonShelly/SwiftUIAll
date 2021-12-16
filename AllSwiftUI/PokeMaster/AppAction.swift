//
//  AppAction.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case logout
    case emailValid(valid: Bool)

    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
}
