//
//  ViewController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var difficulty: UISegmentedControl!
    let segueIdGoToGame = "goToGame"
    var name = ":("
    let difficultyInSeconds = [8,6,4]
    var timePerWord = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        difficulty.selectedSegmentIndex = 1
    }

    @IBAction func difficultyLevel(_ sender: UISegmentedControl) {
        timePerWord = difficultyInSeconds[sender.selectedSegmentIndex]
    }
    @IBAction func startButtonClicked(_ sender: UIButton) {
        let ac = UIAlertController(title: "Let's do this!", message: "What's your name?", preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Yes box", style: .default) { [self, weak ac] action in
            guard let getName = ac?.textFields?[0].text else { return }
            name = getName
            performSegue(withIdentifier: segueIdGoToGame, sender: self)
       }

        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdGoToGame {
            if let destinationVC = segue.destination as? GameViewController
            {
                destinationVC.name = name
                destinationVC.timePerWord = timePerWord
            }
            
        }
    }
}

