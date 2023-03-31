//
//  GameModel.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-30.
//

import Foundation

class GameModel {
    private var words: [String] = ["deadly", "dragon", "cathedral",
    "license", "mole", "withdraw", "camp", "elbow", "authority",
    "offend", "incentive", "crutch", "warm", "tribe", "soprano",
    "alive", "integration", "haskell", "rust", "java", "kotlin",
    "swift", "switch", "lace", "draft", "car", "revoke", "sip",
    "effect", "production", "hostage", "literacy", "cotton",
    "accountant",  "conservative", "management", "imagine",
    "terms", "cheek", "creed", "notorious", "landowner", "pasture",
    "publisher", "praise", "implication", "pigeon", "photography",
    "bishop", "glimpse", "occasion", "emphasis", "seek", "memory"]
    
    func getNextWord() -> String {
        return words.randomElement() ?? ""
    }
    
    func getScore() -> [String: Int] {
        let defaults = UserDefaults.standard
        
        let highscore = defaults.object(forKey:"Highscore") as? [String: Int] ?? [String: Int]()
        
        return highscore
    }
    
    func saveScore(name: String, score: Int) {
        let defaults = UserDefaults.standard
        
        var highscore = defaults.object(forKey:"Highscore") as? [String: Int] ?? [String: Int]()
        
        highscore[name] = highscore[name] ?? score - 1 < score ? score : highscore[name]
                
        let arrayHighscore = highscore.sorted {$0.1 > $1.1}
        let sortedHighscore = Dictionary(uniqueKeysWithValues: Array(arrayHighscore.prefix(10)))
        defaults.set(sortedHighscore, forKey: "Highscore")
        
        
    }
}
