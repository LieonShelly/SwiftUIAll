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
    case register(email: String, password: String, verifyPassword: String)
    // 清空缓存 -> 数据列表为空 -> 页面刷新为try -> 点击try触发下载
    case clearCache
    case clearCacheDone
    
    case toggleListSelection(index: Int?)
    case togglePanelPresenting(presenting: Bool)
    
    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(result: Result<[AbilityViewModel], AppError>)
    
    case closeSafariView
}
