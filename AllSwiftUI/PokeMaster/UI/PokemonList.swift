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
            if store.appState.pokemonList.loadFail {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1.5))
                        .frame(width: 80, height: 30)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.clockwise")
                        Button("Retry") {
                            self.store.dispatch(.loadPokemons)
                        }
                        .font(Font.custom("SF Symbol", size: 13))
                        .foregroundColor(.gray)
                    }
                }
            } else if store.appState.pokemonList.pokemons == nil {
                Text("Loading").onAppear {
                    self.store.dispatch(.loadPokemons)
                }
            } else {
                PokemonList(store: _store)
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
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                ForEach(store.appState.pokemonList.allPokemonsByID) {pokemon in
                    PokemonInfoRow(
                        model: pokemon,
                        expanded: store.appState.pokemonList.expandingIndex == pokemon.id
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
                                if self.store.appState.pokemonList.expandingIndex == pokemon.id {
                                    self.store.appState.pokemonList.expandingIndex = nil
                                } else {
                                    self.store.appState.pokemonList.expandingIndex = pokemon.id
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
