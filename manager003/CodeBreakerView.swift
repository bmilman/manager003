//
//  CodeBreakerView.swift
//  manager003
//
//  Created by bernard milman on 12/18/25.
//

import SwiftUI

struct CodeBreakerView: View {
   
    let game: Codebreaker  = Codebreaker()
    
    var body: some View {
        
        VStack {
            
            pegs(colors: [.yellow, .red, .green, .blue])
            HStack{
                Circle()
                    .foregroundStyle(.red)
                Circle()
                    .foregroundStyle(.green)
                Circle()
                    .foregroundStyle(.red)
                Circle()
                    .foregroundStyle(.yellow)
            }
        }
            }
        
        
        func pegs( colors: [Color])-> some View{
            
            HStack{
           
                ForEach(colors.indices, id:\.self){
                    i in
                    RoundedRectangle(cornerRadius: 10)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundStyle(colors[i])
                }
                MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
            }
    }
    
}


#Preview {
    CodeBreakerView()
}
