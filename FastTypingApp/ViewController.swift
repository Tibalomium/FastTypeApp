//
//  ViewController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-24.
//

import UIKit

class ViewController: UIViewController {
    
    let segueIdGoToGame = "goToGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: segueIdGoToGame, sender: self)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdGoToGame {
            if let destinationVC = segue.destination as? GameViewController
            {
                //destinationVC.recivingName = nameLabel.text
            }
            
        }
    }
}

