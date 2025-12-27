//
//  Code.swift
//  manager003
//
//  Created by bernard milman on 12/22/25.
//


import Foundation
import SwiftUI

struct Code: Hashable {
    //var id: [Peg] {pegs}
    
    var kind: Kind
    var pegs: [Peg] = Array ( repeating: Code.missing, count: 4)
    static let missing: Peg = .clear
    
    enum Kind: Hashable, Equatable {
        case master (isHidden: Bool)
        case guess
        case attempt([Match])
        case unknown
    }
    
    mutating func randomize ( from pegChoices: [Peg]){
        for index in pegs.indices{
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
        print (self)
    }
    
    var isHidden: Bool {
        switch kind {
        case .master( let isHidden) : return isHidden
        default: return false
        }
    }
    
    mutating func reset(){
        pegs =  Array(repeating: Code.missing, count: 4)
    }
    
    var matches: [Match]? {
        switch kind{
        case .attempt(let matches): return matches
        default: return nil
            
        }
    }
    
    func match(against otherCode:Code) -> [Match]{
            // var results: [Match] = Array(repeating: .nomatch, count: pegs.count )
        var pegsToMatch = otherCode.pegs
        
        
        let backwardExactMatches = pegs.indices.reversed().map {
            index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index]{
                pegsToMatch.remove(at: index)
                return Match.exact
            }
            else {return .nomatch }
        }
        
        let exactMatches = Array (backwardExactMatches.reversed())
        
            //        for index in pegs.indices.reversed(){
            //            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index]{
            //                results[index] = .exact
            //                pegsToMatch.remove(at: index)
            //            }
            //        }
            //
        
        return pegs.indices.map { index in
            if exactMatches [index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index])
            {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            }
            else { return exactMatches[index]}
            
                //
                //        for index in pegs.indices {
                //            if results [index] != .exact {
                //                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]){
                //                    results[index] = .inexact
                //                    pegsToMatch.remove(at: matchIndex)
                //                }
                //            }
                //        }
                //        return results
        }
    }
}
