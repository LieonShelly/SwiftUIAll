//
//  PokemonInfoRow.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/12.
//

import Foundation
import SwiftUI

struct PokemonInfoRow: View {
    let model: PokemonViewModel
    @EnvironmentObject var store: Store
    var expanded: Bool

    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 59, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            
            Spacer()
            
            HStack(spacing: expanded ? 20 : -30) {
                Spacer()
                Button(action: { print("Fav") }) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {
                    let target = !self.store.appState.pokemonList.selectionState.panelPresented
                    self.store.dispatch(.togglePanelPresenting(presenting: target))
                }) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                NavigationLink(
                    destination:
                        SafariView(url: model.detailPageURL) {
                            self.store.dispatch(.closeSafariView)
                        }
                        .navigationBarTitle(
                            Text(model.name),
                            displayMode: .inline
                        ),
                    isActive: expanded ?
                    $store.appState.pokemonList.isSFViewActive :
                            .constant(false),
                    label: {
                                Image(systemName: "info.circle")
                                    .modifier(ToolButtonModifier())
                            })

            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1 : 0)
            .frame(maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, model.color]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
        }
        .padding(.horizontal)
     
        
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PokemonInfoRow(model: .sample(id: 1), expanded: false)
            PokemonInfoRow(model: .sample(id: 21), expanded: true)
            PokemonInfoRow(model: .sample(id: 25), expanded: false)
        }
    }
}


struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundStyle(.white)
            .frame(width: 30, height: 30)
    }
}
