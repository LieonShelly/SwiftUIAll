//
//  PokemonInfoPanel.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/13.
//

import Foundation
import SwiftUI

struct PokemonInfoPanel: View {
    let model: PokemonViewModel
    var abilities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    @State
    var darkBlur = false

    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(
                model: model,
                abilityModels: abilities
            )
        }
        .padding(
            EdgeInsets(
                top: 12, leading: 30, bottom: 30, trailing: 30
            )
        )
        .background(Color.white)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
        
    }
}

extension PokemonInfoPanel {
    struct Header: View {
        let model: PokemonViewModel
        
        var body: some View {
            HStack {
                pokemonIcon
                nameSpecies
                verticalDivider
                VStack {
                    bodyStatus
                    typeInfo
                }
            }
        }
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameSpecies: some View {
            VStack(spacing: 10) {
                VStack(spacing: 5) {
                    Text(model.name)
                        .font(
                            .system(size: 22)
                                .bold()
                        )
                        .foregroundColor(model.color)
                    
                    Text(model.nameEN)
                        .font(
                            .system(size: 13)
                                .bold()
                        )
                        .foregroundColor(.gray)
                }
                Text(model.genus)
                    .font(
                        .system(size: 13)
                            .bold()
                    )
                    .foregroundColor(.gray)
            }
        }
        
        var verticalDivider: some View {
            Rectangle()
                .frame(width: 1, height: 44)
                .foregroundColor(
                    Color(hex: 0x000000).opacity(0.1)
                )
        }
        
        var bodyStatus: some View {
            VStack(spacing: 5) {
                HStack(spacing: 2) {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                
                HStack(spacing: 2) {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                
            }
        }
        var typeInfo: some View {
            HStack(spacing: 4) {
                ForEach(model.types) { type in
                    ZStack {
                        RoundedRectangle(cornerRadius: 14 * 0.5)
                            .fill(type.color)
                            .frame(width: 36, height: 14)
                        
                        Text(type.name)
                            .background(.clear)
                            .foregroundColor(.white)
                            .font(.system(size: 11))
                            
                    }
                }
            }
        }
        
    }
}

extension PokemonInfoPanel {
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                
                if let abilityModels = abilityModels {
                    ForEach(abilityModels) { ability in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
