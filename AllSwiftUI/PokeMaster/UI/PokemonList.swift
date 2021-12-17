//
//  PokemonList.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/13.
//

import Foundation
import SwiftUI

struct PokemonRootView: View {
    
    @EnvironmentObject
    var store: Store
    
    var body: some View {
        NavigationView {
            if store.appState.pokemonList.pokemons == nil {
                Text("Loading").onAppear {
                    self.store.dispatch(.loadPokemons)
                }
            } else {
                PokemonList()
                    .navigationBarTitle("宝可梦列表")
            }
        }
    }
}

struct PokemonListRoot_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}


struct PokemonList: View {
    @EnvironmentObject
    var store: Store
    @State var expandingIndex: Int?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                ForEach(store.appState.pokemonList.allPokemonsByID) {pokemon in
                    PokemonInfoRow(
                        model: pokemon,
                        expanded: self.expandingIndex == pokemon.id
                    )
                        .onTapGesture {
                            withAnimation(
                                .spring(
                                    response: 0.55,
                                    dampingFraction: 0.4,
                                    blendDuration: 0
                                )
                            )
                            {
                                if self.expandingIndex == pokemon.id {
                                    self.expandingIndex = nil
                                } else {
                                    self.expandingIndex = pokemon.id
                                }
                            }
                        }
                }
            }
        }
//        .overlay(
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom)
//        )
    }
}
