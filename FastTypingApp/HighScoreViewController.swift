//
//  HighScoreViewController.swift
//  FastTypingApp
//
//  Created by Håkan Johansson on 2023-03-30.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource {

    var model: GameModel?
    
    var gameData = [(String, Int)]()

    @IBOutlet weak var highscoreTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model {
            gameData = Array(model.getScore().sorted {$0.1 > $1.1})
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
