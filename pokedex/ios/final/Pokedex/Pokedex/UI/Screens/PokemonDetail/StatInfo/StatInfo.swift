//
//  StatInfo.swift
//  Pokedex
//
//  Created by Giertl Matúš on 21.07.2022.
//

import SwiftUI

struct StatInfo: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
        }
        .padding(.bottom)
        .padding(.horizontal, 30)
    }
}


struct StatInfo_Previews: PreviewProvider {
    static var previews: some View {
        StatInfo(label: "HP", value: "55")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
