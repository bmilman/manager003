//
//  CodeView.swift
//  manager003
//
//  Created by bernard milman on 12/22/25.
//

import SwiftUI

struct CodeView<AncillaryView>: View  where AncillaryView: View {
    
    let code: Code
    @Namespace private var selectionNameSpace
    
    
   //MARK: DATA SHARED WITH ME
    
    @Binding var selection: Int
    
  @ViewBuilder  let ancillaryView: () -> AncillaryView
    
    init(
        code: Code,
        selection: Binding <Int> = .constant(-1),
    @ViewBuilder ancillaryView: @escaping () -> AncillaryView = {EmptyView()}
    )
    {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    
        //MARK: - Body
    
    var body: some View {
        
        HStack{
       
            ForEach(code.pegs.indices, id:\.self){
                index in
                PegView(peg:code.pegs [index])
                    .background {
                        Group{
                            if selection == index, code.kind == .guess{
                                Circle()
                                    .foregroundColor(Color.gray(0.85))
                                    //.matchedGeometryEffect(id: "selection", in: selectionNameSpace)
                            }
                        }
                       // .animation(selection, value: selectionNameSpace)
                    }
                    .overlay {
                       Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundStyle(code.isHidden ? Color.gray : .clear)
                            //.animation(nil, value: code.isHidden)
                            .transaction { transaction in
                                if code.isHidden {
                                    transaction.animation = nil
                                }
                            }
                    }
                    .onTapGesture {
                        if code.kind == .guess{
                            selection  = index
                        }
                    }
            }
            Rectangle()
                .foregroundStyle(Color.clear)
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView()
                }
           
            }
            
        
    }
}

//#Preview {
//    CodeView (code:code, selection: $selection)
//}
