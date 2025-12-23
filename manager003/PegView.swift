//
//  PegView.swift
//  manager003
//
//  Created by bernard milman on 12/22/25.
//

import SwiftUI

struct PegView: View {
    
    //MARK: Data In
    let peg: Peg
    
    //MARK: - BODY
   let pegShape = RoundedRectangle (cornerRadius: 10)
    var body: some View {
            pegShape
//            .overlay{
//                if peg == Code.missing {
//                    pegShape
//                    .strokeBorder(Color.gray)
//                }
//            }
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(peg)
    }
}

#Preview {
    PegView(peg: .blue)
        .padding()
}
