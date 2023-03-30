//
//  GameModel.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-30.
//

import Foundation

class GameModel {
    private var words: [String] = []
    
    init() {
        initializeWords()
    }
    
    func initializeWords() {
        words.append("Hejsan")
        words.append("Hoppsan")
        words.append("Jobbar")
        words.append("Pizza")
        words.append("Lastbilen")
    }
    
    func getNextWord() -> String {
        return words.popLast() ?? ""
    }
    
    func getScore() -> [String: Int] {
        let defaults = UserDefaults.standard
        
        var highscore = defaults.object(forKey:"Highscore") as? [String: Int] ?? [String: Int]()
        
        return highscore
    }
    
    func saveScore(name: String, score: Int) {
        let defaults = UserDefaults.standard
        
        var highscore = defaults.object(forKey:"Highscore") as? [String: Int] ?? [String: Int]()
        
        highscore[name] = highscore[name] ?? score - 1 < score ? score : highscore[name]
                
        let arrayHighscore = highscore.sorted {$0.1 > $1.1}
        let sliceArrayHighscore = Array(arrayHighscore.prefix(10))
        let sortedHighscore = Dictionary(uniqueKeysWithValues: sliceArrayHighscore)
        defaults.set(sortedHighscore, forKey: "Highscore")
        
        
    }
}
