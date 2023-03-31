//
//  HighScoreViewController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-30.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource {

    var model: GameModel?
    var currentScore = 0
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    var gameData = [(String, Int)]()

    @IBOutlet weak var highscoreTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model {
            gameData = Array(model.getScore().sorted {$0.1 > $1.1})
        }
        playerScoreLabel.text = "Your score: \(currentScore)"
        highscoreTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = highscoreTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = gameData[indexPath.row].0
        cell.scoreLabel.text = String(gameData[indexPath.row].1)
        
        return cell
        
    }

    @IBAction func playAgain(_ sender: Any) {
       performSegue(withIdentifier: "unwindToBeg", sender: self)
    }
}
