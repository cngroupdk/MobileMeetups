import SharedKit
import SwiftUI

struct PokemonTypes: View {

    let types: [PokemonType]

    var body: some View {
        if !types.isEmpty {
            HStack {
                ForEach(types, id: \.type.name) { type in
                    Group {
                        Text(verbatim: "\(type.type.name)")
                    }
                    .padding(Theme.space.s1)
                    .background(Theme.colors.primaryContainer)
                    .clipShape(
                        RoundedCornersShape(
                            radius: Theme.radii.r2,
                            corners: [.allCorners]
                        )
                    )
                }
            }
            .padding(Theme.space.s1)
        }
    }
}

#if DEBUG
    struct PokemonTypes_Previews: PreviewProvider {
        static var previews: some View {
            PokemonTypes(
                types: [
                    PokemonType(
                        slot: 1,
                        type: Species(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")
                    ),
                    PokemonType(
                        slot: 2,
                        type: Species(name: "poison", url: "https://pokeapi.co/api/v2/type/4/")
                    ),
                ]
            )
            .previewLayout(.sizeThatFits)
        }
    }
#endif
