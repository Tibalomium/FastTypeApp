//
//  GameViewController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-24.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var wordToType: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    private var controller: GameController = GameController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.start(gvc: self)
    }
    
    @IBAction func userTyped(_ sender: UITextField) {
        if let input = userInput.text {
            controller.inputUpdated(input: input)
        }
    }
    
    func errorLastChar() {
        var index = -1
        
        index += userInput.text?.count ?? 0
        
        //remove first if-statement?
        if let word = wordToType.text,
           let userWord = userInput.text {
            //move into varibles for clarity
            if index >= 0 && index < word.count && String(word[word.index(word.startIndex, offsetBy: index)]) == String(userWord[userWord.index(userWord.startIndex, offsetBy: index)]) {
            }
            else if userWord.count > 0 {
                if let text = userInput.attributedText {
                    let string = NSMutableAttributedString(attributedString: text)
                    string.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location:index,length:1))
                    userInput.attributedText = string
                }
            }
        }
    }
    
    func setScore(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    
    func setTime(time: Int) {
        timeLeftLabel.text = "Time: \(time)"
    }
    
    func setWordToType(word: String) {
        wordToType.text = word
    }
    
    func clearInput() {
        userInput.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class GameController {

    private let model = GameModel()
    private var currentWord = ""
    private var currentScore  = 0
    private var view: GameViewController?
    private var timer: Timer?
    private var time = 8
    
    init() {
        currentWord = model.getNextWord()
    }
    
    func start(gvc: GameViewController) {
        view = gvc
        reset()
    }
    
    func reset() {
        view?.setWordToType(word: currentWord)
        view?.setScore(score: currentScore)
        view?.clearInput()
        time = 8
        resetTimer()
    }
    
    func inputUpdated(input: String) {
        if input == currentWord {
            currentScore += time > 1 ? 1 : -1
            currentWord = model.getNextWord()
            if currentWord == "" {
                
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
        //remove else
        else {
            return false
        }
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
    
    func saveScore(name: String, score: Int) {
        let defaults = UserDefaults.standard
        
        var highscore = defaults.object(forKey:"Highscore") as? [String: Int] ?? [String: Int]()
        
        /*if highscore.keys.contains(name) && highscore[name] < score {
            highscore[name] = score
        }*/
        
        //let sortedHighscore = highscore.sorted(by: >).filter({highscore[$0].})
        
    }
}
