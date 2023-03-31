//
//  GameController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-30.
//

import Foundation

class GameController {

    private let model = GameModel()
    private var currentWord = ""
    private var currentScore  = 0
    private var view: GameViewController?
    private var timer: Timer?
    private var timePerWord = 0
    private var time = 0
    var name: String = ""
    var wordPlayedCounter = 10
    
    init() {
        currentWord = model.getNextWord()
    }
    
    func start(gvc: GameViewController, timePerWord: Int, name: String) {
        view = gvc
        self.timePerWord = timePerWord
        self.name = name
        reset()
    }
    
    func reset() {
        time = timePerWord
        view?.setWordToType(word: currentWord)
        view?.setScore(score: currentScore)
        view?.clearInput()
        view?.setTime(time: timePerWord)
        resetTimer()
    }
    
    func inputUpdated(input: String) {
        if input == currentWord {
            currentScore += time > 0 ? 1 : -1
            currentWord = model.getNextWord()
            wordPlayedCounter -= 1
            if currentWord == "" || wordPlayedCounter == 0 {
                model.saveScore(name: name, score: currentScore)
                view?.segueToHighscore(model: model, currentScore: currentScore)
            }
            else {
                reset()
            }
        }
        else if !isCorrectChar(input: input) {
            view?.errorLastChar()
        }
    }
    
    func isCorrectChar(input: String) -> Bool {
        let index = input.count - 1
        
        if index >= 0 && index < currentWord.count && String(currentWord[currentWord.index(currentWord.startIndex, offsetBy: index)]) == String(input[input.index(input.startIndex, offsetBy: index)]) {
            
            return true
        }
        
        return false
    }
    
    func timerTick(timer: Timer) {
        time -= time > 0 ? 1 : 0
        view?.setTime(time: time)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: timerTick(timer:))
    }
    
    
    deinit {
        timer?.invalidate()
    }
}
