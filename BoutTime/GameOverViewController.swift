//
//  GameOverViewController.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/26/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    var game: Game!
    weak var mainViewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        game = appDelegate.game
        updateScore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateScore()
    }
    
    /// Update the score label
    func updateScore() {
        scoreLabel.text = "\(game.numCorrect)/\(game.numRounds)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playAgain() {
        // Dismiss
        dismiss(animated: true, completion: nil)
        
        // Start a new game
        if let vc = self.mainViewController {
            vc.startNewGame()
        } else {
            print("Could not start a new game! This should never happen!")
        }
    }
}
