//
//  PokemonList.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/13.
//

import Foundation
import SwiftUI

struct PokemonRootView: View {
    var body: some View {
        NavigationView {
            PokemonList().navigationBarTitle("宝可梦列表")
        }
    }
}

struct PokemonListRoot_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}


struct PokemonList: View {
    @State var expandingIndex: Int?
    @State var searchText: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                TextField("Seacrh", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                    .padding()
                    .onSubmit {
                        
                    }
                
                ForEach(PokemonViewModel.all) {pokemon in
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
        .overlay(
            VStack {
                Spacer()
                PokemonInfoPanel(model: .sample(id: 1))
            }.edgesIgnoringSafeArea(.bottom)
        )
    }
}
