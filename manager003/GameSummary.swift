//
//  GameSummary.swift
//  manager003
//
//  Created by bernard milman on 12/25/25.
//

import SwiftUI

struct GameSummary: View {
    
    let game: Codebreaker
    
    
    var body: some View {
        VStack (alignment: .leading)  {
            Text (game.name)
                .font(.title)
            PegChooser (choices: game.pegChoices, onChoose: nil)
                .frame (maxHeight: 50 )
            Text (" \(game.attempts.count) attempt")
            
            //Text( "^[\(game.attempts.count ) attempt] (inflect: true)") //doesn't work
        }
        .listRowSeparator(.hidden)
        .listRowBackground(RoundedRectangle(cornerRadius: 10)
        .foregroundStyle(.indigo)
        .padding(5))    }
}

#Preview {
    
    List{
        GameSummary( game: Codebreaker(name: "preview", pegChoices: [.red, .mint, .teal]))
    }
    
    List{
        GameSummary( game: Codebreaker(name: "preview", pegChoices: [.red, .mint, .teal]))
    }
    .listStyle(.plain)
}
