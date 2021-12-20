//
//  MainTab.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/16.
//

import Foundation
import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
    private var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    private var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }
    
    private var selectedPanelIndex: Int? {
        pokemonList.selectionState.panelIndex
    }
    
    var body: some View {
        TabView {
            PokemonRootView().tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
        }
        .edgesIgnoringSafeArea(.top)
        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
            if self.selectedPanelIndex != nil &&
                self.pokemonList.pokemons != nil {
                PokemonInfoPanel(
                    model: self.pokemonList.pokemons![self.selectedPanelIndex!]!
                )
            }
        }
    }
}
