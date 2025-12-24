//
//  PegChooser.swift
//  manager003
//
//  Created by bernard milman on 12/22/25.
//

import SwiftUI

struct PegChooser: View {
    
    let choices: [Peg]
    let onChoose: ((Peg) -> Void)?
    
    
    var body: some View {
        
            HStack{
                ForEach (choices, id: \.self) { peg in
                    Button {
                        onChoose? (peg)
                    }
                    label: {
                        PegView(peg: peg)
                    }
                }
            }
        }
            }


//#Preview {
//    PegChooser()
//}
