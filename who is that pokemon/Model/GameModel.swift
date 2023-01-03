//
//  GameModel.swift
//  who is that pokemon
//
//  Created by User on 14/12/22.
//

import Foundation

struct GameModel {
    var score = 0
    
    // Check correct answer
    mutating func checkAnswer(_ userAnswer: String, _ correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            score += 1
            return true
        }
        return false
    }
    
    // Get Score
    func getScore() -> Int {
        return score
    }
    
    // Reset Score
    mutating func setScore(score: Int) {
        self.score = score
    }
}
