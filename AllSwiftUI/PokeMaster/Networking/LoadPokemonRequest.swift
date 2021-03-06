//
//  LoadPokemonRequest.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/17.
//

import Foundation
import Combine

struct LoadPokemonRequest {
    static var all: AnyPublisher<[PokemonViewModel], AppError> {
        (1 ... 30)
            .map { LoadPokemonRequest(id: $0).publisher }
            .zipAll
    }
    let id: Int
    
    var publisher: AnyPublisher<PokemonViewModel, AppError> {
        pokemonPublisher(id)
            .flatMap {self.speciesPublisher($0)}
            .map { PokemonViewModel(pokemon: $0, species: $1) }
            .mapError { AppError.networkingFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func pokemonPublisher(_ id: Int) -> AnyPublisher<Pokemon, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!)
            .mapError { AppError.networkingFailed($0)}
            .print()
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
    
    private func speciesPublisher(_ pokemon: Pokemon) -> AnyPublisher<(Pokemon, PokemonSpecies), Error> {
        URLSession.shared
            .dataTaskPublisher(for: pokemon.species.url)
            .map { $0.data }
            .decode(type: PokemonSpecies.self, decoder: appDecoder)
            .map { (pokemon, $0) }
            .eraseToAnyPublisher()
    }
}
