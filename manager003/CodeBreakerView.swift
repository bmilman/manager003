//
//  CodeBreakerView.swift
//  manager003
//
//  Created by bernard milman on 12/18/25.
//

import SwiftUI

struct CodeBreakerView: View {
   
  
//MARK: DATA SHARED WITH ME
   // @Binding  var - for structure
   let  game: Codebreaker //for class
  
        //MARK: DATA OWNED BY ME
    // @State private var game = Codebreaker()
    
   @State private var selection: Int = 0
    
    var body: some View {
        
        VStack {
            withAnimation (.restart) {
                Button ("Restart"){
                    game.restart()
                    selection = 0
                }
            }
            
            CodeView(code: game.masterCode) {
                ElapsedTime (startTime: game.startTime, endTime: game.endTime)
                    .monospaced()
            }
 
            
            //                    , selection: $selection, ancillaryView: { Text ("0:03") .font ( .title)}
            
            
            ScrollView{
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection ) { guessButton }
                        .animation(nil, value: game.attempts.count)
                }
                    
                    
                ForEach ( game.attempts.reversed()
                          , id: \.pegs
               ) {
                    attempt in
                    CodeView(code: attempt) {
                        if let matches = attempt.matches {
                            MatchMarkers(matches: matches)
                        }
                        //MatchMarkers(matches: game.attempts[index].matches ?? [])
                    }
                    
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .top),
                                                         removal: .move(edge: .trailing))
                        
                        )
                    
                }
            }
           
            if !game.isOver{
                PegChooser (choices: game.pegChoices, onChoose: changePegAtSelection)
                    .transition(.pegChooser)
                    //.transition(.move(edge: .bottom))
            }
                
               
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .primaryAction) {
                Button ("Restart", systemImage: "arrow.circlepath") {game.restart()}

            }
            ToolbarItem{
                ElapsedTime (startTime: game.startTime, endTime: game.endTime)
                    .monospaced()
                    .lineLimit(1)
            }
        }
            }
        
    func changePegAtSelection (to peg:Peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
    }
    
    
    var guessButton: some View {
        Button("Guess") {
            
            withAnimation(.guess)  {
                game.attemptGuess()
                selection = 0
            }
            
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.1)
    }
        
        
        //func pegs( colors: [Color])-> some View{
   
    
    
    struct Selection {
        //put some constants : static let ....
    }
    }
    
extension Animation {
    static let guess = Animation.easeInOut(duration: 3)
    static let restart = Animation.easeInOut(duration: 5)
}

extension AnyTransition {
    static let pegChooser = AnyTransition.offset(x:0, y: 200)
//    static func attempt (_isOver: Bool) -> AnyTransition {
//        AnyTransition.asymmetric(insertion: .move(edge: .top),
//                                 removal: .move(edge: .trailing)    }
}


extension Color {
    static func gray (_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}


#Preview {
   @Previewable @State  var game = Codebreaker(name: "PREVIEW", pegChoices: [.blue, .red, .purple])
    CodeBreakerView(game: game)
}
