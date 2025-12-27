//
//  CodebreakerModel.swift
//  manager003
//
//  Created by bernard milman on 12/20/25.
//

import Foundation
import SwiftUI


typealias Peg = Color

@Observable class  Codebreaker {
    
  
  
    var name: String
    var masterCode:Code = Code(kind: .master (isHidden: true))
    var guess:Code = Code(kind: .guess)
    var attempts : [Code] = [Code]()
    var pegChoices: [Peg]
    var startTime: Date = Date.now
    var endTime: Date?
    
    init(name: String = "Code Breaker", pegChoices: [Peg] = [.red, .green, .blue, .yellow]) {
        self.name = name
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }

    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
     func restart () {
        masterCode.kind = .master(isHidden: true)
        masterCode.randomize(from: pegChoices)
        guess.reset()
        attempts.removeAll()
        startTime = Date.now
        endTime = nil
    }
    
   
//    mutating func attemptGuess() {
//        guard !attempts.contains(where: { $0.pegs == guess.pegs }) else { return }
//        var attempt = guess
//        attempt.kind = .attempt(guess.match(against: masterCode))
//        attempts.insert(attempt, at: 0)
//        guess.reset()
//        if isOver {
//            endTime = .now
//            masterCode.kind = .master(isHidden: false)
//        }
//    }
    
     func attemptGuess() {
        guard !attempts.contains(where: {$0.pegs == guess.pegs}) else {return}
        var attempt = guess
        attempt.kind = .attempt (guess.match(against: masterCode))
        attempts.insert(attempt, at: 0)
        guess.reset()
        if isOver {
            masterCode.kind = .master(isHidden: false)
            endTime = Date.now
        }
    }
    
     func setGuessPeg(_ peg:Peg,  at index: Int){
        guard guess.pegs.indices.contains(index) else {return}
        guess.pegs [index] = peg
    }
    
    
    
     func changeGuessPeg (at index:Int){
        let existingPeg = guess.pegs[index]
        if  let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices [ (indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs [index] = newPeg
        }
        else{
            guess.pegs [index] = pegChoices.first ?? Code.missing
        }
    }
}


extension Codebreaker : Identifiable, Hashable, Equatable {
    
    static func == (lhs: Codebreaker, rhs: Codebreaker) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash (into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    }
