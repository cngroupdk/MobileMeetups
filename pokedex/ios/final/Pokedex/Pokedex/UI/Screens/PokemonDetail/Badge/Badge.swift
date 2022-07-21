//
//  Badge.swift
//  Pokedex
//
//  Created by Giertl Matúš on 21.07.2022.
//

import SwiftUI

struct Badge: View {
    let type: String?
    
    private var cardColor: Color? {
        guard let type = type,
            let colorHex = Constant.pokemonTypeColors[type]
        else { return nil }
        return Color(hex: colorHex).opacity(0.4)
    }
    
    var body: some View {
        Text(type ?? "")
            .font(.footnote)
            .bold()
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(cardColor)
            .foregroundColor(.white)
            .cornerRadius(5)
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(type: "Grass")
    }
}
