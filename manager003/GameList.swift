//
//  GameList.swift
//  manager003
//
//  Created by bernard milman on 12/27/25.
//

import SwiftUI

struct GameList: View {
    
        //MARK: Data owned by me
    @State private var games : [Codebreaker] = []
    
        //MARK: DATA SHARED WITH ME
    @Binding var selection: Codebreaker?
    
    var body: some View {
        
        List(selection: $selection){
            ForEach(games)
            { game in
                
                NavigationLink (value: game) {
                    GameSummary(game: game)
                }
                
                NavigationLink (value: game.masterCode.pegs) {
                    Text ("Cheat")
                }
                    //fo Mac and Ipad, right mouse click or press AND hold
                .contextMenu{
                    Button ("Delete", systemImage: "minus.circle", role: .destructive){
                        games.removeAll {$0 == game}
                    }
                }
                
            }
            .onDelete { offsets in
                games.remove (atOffsets: offsets)
            }
            .onMove{
                offsets, destination in
                games.move(fromOffsets: offsets, toOffset: destination)
                
            }
        }
        .onChange(of: games){
            
        }
        
        .listStyle(.grouped)
        .toolbar{
            Button("AddGame", systemImage: "plus"){
                withAnimation{
                    let newGame = Codebreaker(name: "Untitled", pegChoices: [.red, .yellow])
                    games.append(newGame)
                }
            }
            EditButton()
            
        }
        
        .onAppear{
                // addSampleGames(), can't make it work
            if games.isEmpty{
                games.append(Codebreaker(name: " Trois", pegChoices: [ Color( .brown), Color(.orange),  .yellow   ]))
                games.append(  Codebreaker(name: "Cinq",pegChoices: [ Color( .red), Color(.cyan), .black, .yellow, .green   ]))
                games.append(  Codebreaker(name: "Quatre",pegChoices: [ Color( .blue), Color(.orange), .black, .green   ]))
                selection = games.first        }
            
        }
        
      //  func addSampleGames(){ }
        
    }
}
#Preview {
    @Previewable @State var selection:Codebreaker?
    NavigationStack{
        GameList( selection: $selection)
    }
}
