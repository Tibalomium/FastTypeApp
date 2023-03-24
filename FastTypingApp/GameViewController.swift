//
//  GameViewController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-24.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var wordToType: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    //To not have to nil check
    var controller: GameController = GameController(ui:UIViewController())
    
    var formattedString = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = GameController(ui:self)
    }
    
    //TODO: Erase of first character crashes the program
    @IBAction func userTyped(_ sender: UITextField) {
        
        var index = -1
        
        index += userInput.text?.count ?? 0
        
        if let word = wordToType.text,
           let userWord = userInput.text {
            if index >= 0 && index < word.count && String(word[word.index(word.startIndex, offsetBy: index)]) == String(userWord[userWord.index(userWord.startIndex, offsetBy: index)]) {
            }
            else {
                if let text = userInput.attributedText {
                    let string: NSMutableAttributedString
                    string = NSMutableAttributedString(attributedString: text)
                    string.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location:index,length:1))
                    userInput.attributedText = string
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

class GameController {
    
    let ui: UIViewController
    let model = GameModel()
    
    init(ui: UIViewController) {
        self.ui = ui
    }
    
    func isCorrect(input: String) -> Bool {
        return false
    }
}

class GameModel {
    var words: [String] = []
    var currentWord: String = ""
    
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
}
