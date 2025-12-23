//
//  MatchMarkers.swift
//  manager003
//
//  Created by bernard milman on 12/19/25.
//

import SwiftUI


enum Match{
    case nomatch
    case exact
    case inexact
    
}


struct MatchMarkers: View {
    
    let matches: [Match]
    
    var body: some View {
        HStack{
            VStack{
                matchMaker(peg: 0)
                matchMaker(peg: 1)
            }
            VStack{
                matchMaker(peg: 2)
                matchMaker(peg: 3)
            }
        }
            }
    
    func matchMaker (peg: Int) -> some View{
        
        let exactCount = matches.count  {$0 == .exact}
        let foundCount = matches.count {$0 != .nomatch}
        
        //Int = matches.count (where: {match in match != .nomatch})
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
        
    }
    
    func isExact (match: Match)-> Bool{
        
       match == .exact
    }
}



#Preview {
    MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
}
