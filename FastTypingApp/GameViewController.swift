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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
