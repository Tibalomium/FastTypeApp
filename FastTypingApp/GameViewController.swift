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
    private var timer: Timer?
    private var time = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordToType.text = controller.getWord()
        setScore(score: 0)
        updateTime()
        resetTimer()
    }
    
    func timerTick(timer: Timer) {
        time -= time > 0 ? 1 : 0
        updateTime()
    }
    
    @IBAction func userTyped(_ sender: UITextField) {
        if let word = userInput.text {
            if controller.checkInput(input: word, time: time) {
                wordToType.text = controller.getWord()
                userInput.text = ""
                setScore(score: controller.getScore())
                time = 5
                updateTime()
                resetTimer()
                if wordToType.text == "" {
                    timer?.invalidate()
                    wordToType.text = "Good Job!!"
                }
            }
            else if !controller.isCorrectChar(input: word) {
                errorLastChar()
            }
        }
    }
    
    func errorLastChar() {
        var index = -1
        
        index += userInput.text?.count ?? 0
        
        //remove first if-statement
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
    
    private func setScore(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    
    private func updateTime() {
        timeLeftLabel.text = "Time: \(time)"
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: timerTick(timer:))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        timer?.invalidate()
    }

}

class GameController {

    private let model = GameModel()
    private var currentWord = ""
    private var currentScore: Int  = 0
    
    init() {
        currentWord = model.getNextWord()
    }
    
    func checkInput(input: String, time: Int) -> Bool {
        if input == currentWord {
            currentWord = model.getNextWord()
            if time > 1 {
                currentScore += 1
            }
            else {
                currentScore -= 1
            }
            return true
        }
        return false
    }
    
    func isCorrectChar(input: String) -> Bool{
        let index = input.count - 1
        
        if index >= 0 && index < currentWord.count && String(currentWord[currentWord.index(currentWord.startIndex, offsetBy: index)]) == String(input[input.index(input.startIndex, offsetBy: index)]) {
            
            return true
        }
        //remove else
        else {
            return false
        }
    }
    
    func getWord() -> String {
        return currentWord
    }
    func getScore() -> Int {
        return currentScore
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
}
