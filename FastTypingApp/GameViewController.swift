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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = GameController(ui:self)
    }
    
    @IBAction func userTyped(_ sender: UITextField) {
        /*if wordToType.text == userInput.text {
            wordToType.text = "Winner!"
        }*/
        let a = controller.isCorrect(input:"Winner")
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
