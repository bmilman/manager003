//
//  GameEditor.swift
//  manager003
//
//  Created by bernard milman on 12/27/25.
//

import SwiftUI

struct GameEditor: View {
   @Bindable var game: Codebreaker
    
    var body: some View {
        Form{
            
            Section ("Name"){
                TextField("name", text:$game.name)
            }
            
            Section ("Pegs"){
                List{
                    ForEach(game.pegChoices.indices, id: \.self) {index in
                        ColorPicker (
                            selection: $game.pegChoices [index],
                            supportsOpacity: false
                        )
                        {
                            Text ( "peg choices \(index+1)")
                        }
                    }
                }            }
            
        }
    }
}

#Preview {
   @Previewable  let game = Codebreaker(name: "preview", pegChoices: [.orange, .indigo])
    GameEditor(game: game)
        .onChange(of: game.name) {
            print ("game name changed to \(game.name)")
        }
        .onChange(of: game.pegChoices) {
            print ("game pegs changed to \(game.pegChoices)")
        }
}
