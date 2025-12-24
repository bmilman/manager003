//
//  CodeBreakerView.swift
//  manager003
//
//  Created by bernard milman on 12/18/25.
//

import SwiftUI

struct CodeBreakerView: View {
   
   @State private var game = Codebreaker()
    
   @State private var selection: Int = 0
    
    var body: some View {
        
        VStack {
            withAnimation (.restart) {
                Button ("Restart"){
                    game.restart()
                    selection = 0
                }
            }
            
            CodeView(code: game.masterCode
//                    , selection: $selection, ancillaryView: { Text ("0:03") .font ( .title)
//            }
            )
            
            ScrollView{
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection ) { guessButton }
                        .animation(nil, value: game.attempts.count)
                }
                    
                    
                ForEach ( game.attempts.indices.reversed(), id: \.self) {
                    index in
                    CodeView(code: game.attempts[index],
                             ancillaryView: {
                        if let matches = game.attempts[index].matches {
                            MatchMarkers(matches: matches)
                        }
                        //MatchMarkers(matches: game.attempts[index].matches ?? [])
                    }
                    )
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
                
//            {peg in
//       changePegAtSelection(to: peg)
//            }
        }
        .padding()
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
    CodeBreakerView()
}
