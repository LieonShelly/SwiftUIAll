//
//  AppCommand.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation
import Combine

protocol AppCommand {
    func execute(in store: Store)
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(
                        .accountBehaviorDone(result: .failure(error))
                    )
                }
                token.unseal()
            }, receiveValue: { user in
                store.dispatch(
                    .accountBehaviorDone(result: .success(user))
                )
            })
            .seal(in: token)
    }
}

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}


struct LoadPokemonsCommand: AppCommand {
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadPokemonRequest.all
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadPokemonsDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { value in
                store.dispatch(.loadPokemonsDone(result: .success(value)))
            })
            .seal(in: token)
    }
}

struct RegisterCommand: AppCommand {
    let email: String
    let password: String
    let verifyPassword: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        store.appState.settings.checker.emailCanRegister
            .filter { can in
                if !can {
                    store.dispatch(.accountBehaviorDone(result: .failure(.emailExist)))
                }
                return can == true
            }
            .flatMap { _ in
                RegisterRequest(email: email, password: password, verifyPassword: verifyPassword)
                    .publisher
            }
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            })
            .seal(in: token)
    }
}

struct ClearCacheCommand: AppCommand {
    
    func execute(in store: Store) {
        try? FileHelper.delete(from: .cachesDirectory, fileName: "pokemons.json")
        store.dispatch(.clearCacheDone)
    }
}
