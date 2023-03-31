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
    var name: String = ""
    let segueIdGoToHighScore = "goToEnd"
    var gameModel: GameModel?
    var currentScore = 0
    var timePerWord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInput.becomeFirstResponder()
        controller.start(gvc: self, timePerWord: timePerWord, name: name)
    }
    
    @IBAction func userTyped(_ sender: UITextField) {
        if let input = userInput.text {
            controller.inputUpdated(input: input)
        }
    }
    
    //To mark last char typed as wrong
    func errorLastChar() {
        if let text = userInput.attributedText {
            if text.length > 0 {
                let index = -1 + text.length
                
                let string = NSMutableAttributedString(attributedString: text)
                string.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location:index,length:1))
                userInput.attributedText = string
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
    
    func segueToHighscore(model: GameModel, currentScore: Int) {
        gameModel = model
        self.currentScore = currentScore
        performSegue(withIdentifier: segueIdGoToHighScore, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdGoToHighScore {
            if let destinationVC = segue.destination as? HighScoreViewController
            {
                if let gameModel {
                    destinationVC.model = gameModel
                    destinationVC.currentScore = currentScore
                }
            }
        }
    }
}
