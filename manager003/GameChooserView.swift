//
//  GameChooserView.swift
//  manager003
//
//  Created by bernard milman on 12/25/25.
//

import SwiftUI

struct GameChooserView: View {
    

    
    @State private var selection: Codebreaker? = nil
    
    
    var body: some View {
        NavigationSplitView {
          
            GameList(selection: $selection)
            
           
            .navigationTitle("CodeBreaker")
//            .navigationDestination(for: Codebreaker.self) { game in
//                 CodeBreakerView(game: game)
//                    .navigationTitle(game.name)
//             }
            
            .navigationDestination(for: [Peg].self) { pegs in
               
                PegChooser(choices: pegs, onChoose: nil)
            }
        } detail: {
            if let selection{
                CodeBreakerView(game: selection)
                   .navigationTitle(selection.name)
                   .navigationBarTitleDisplayMode(.inline)
            } else {
                Text( "Choose a game")
            }
        }
                
 
            

        
         

        }
        
        
        
        
        
    }


#Preview {
    GameChooserView()
}
   
    
    //  MARK:  for Struc
//                Section ("GAMES"){
//                    ForEach  ( $games, id: \.pegChoices, editActions: [.delete, .move]){ $game in
//
//                        NavigationLink{
//                            CodeBreakerView(game: $game)                        }
//                        label: {
//                            GameSummary (game: game)
//                        }
//                    }
//                }
//
//                Section (header: Image(systemName: "face.smiling") .font(.title)){
//                    Text("hello")
//                    Text("buy")
//                }



    //                    NavigationLink{
    //                        CodeBreakerView(game: game)
    //                    }
    //                    label: {
    //                        GameSummary (game: game)
    //                    }
