//
//  RegisterRequest.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/18.
//

import Foundation
import Combine

struct RegisterRequest {
    let email: String
    let password: String
    let verifyPassword: String
    
    var publisher: AnyPublisher<User, AppError> {
        Future<User, AppError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                if password != verifyPassword {
                    promise(.failure(.passwordNotEqual))
                } else {
                    let user = User(email: email, favoritePokemonIDs: [])
                    promise(.success(user))
                }
              
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

