//
//  ViewController.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/24/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var eventButton0: UIButton!
    @IBOutlet weak var eventButton1: UIButton!
    @IBOutlet weak var eventButton2: UIButton!
    @IBOutlet weak var eventButton3: UIButton!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    /// If true, dates will be shown with the description
    let helpMode = false
    /// Date formatter for help mode
    let dateFormatter = DateFormatter()
    
    /// The object that manages all game logic
    var game: Game!
    /// The countdown timer for the game
    var timer: Timer?
    /// Contains eventButtons 0-4
    var eventButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        eventButtons = [eventButton0, eventButton1, eventButton2, eventButton3]
        nextRoundButton.isHidden = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        game = appDelegate.game
        startNewGame()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        checkEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Set GameOverViewController.mainViewController so that it
        // can call functions on this ViewController.
        if let destVC = segue.destination as? GameOverViewController {
            destVC.mainViewController = self
        }
    }
    
    @IBAction func moveEventDown0() {
        game.swapEvents(index1: 0, index2: 1)
        updateEventsUI()
    }
    
    @IBAction func moveEventUp1() {
        game.swapEvents(index1: 0, index2: 1)
        updateEventsUI()
    }
    
    @IBAction func moveEventDown1() {
        game.swapEvents(index1: 1, index2: 2)
        updateEventsUI()
    }
    
    @IBAction func moveEventUp2() {
        game.swapEvents(index1: 1, index2: 2)
        updateEventsUI()
    }
    
    @IBAction func moveEventDown2() {
        game.swapEvents(index1: 2, index2: 3)
        updateEventsUI()
    }
    
    @IBAction func moveEventUp3() {
        game.swapEvents(index1: 2, index2: 3)
        updateEventsUI()
    }
    
    @IBAction func nextRound() {
        startRound()
    }
    
    /// Start a new game
    func startNewGame() {
        game.newGame()
        startRound()
    }
    
    /// Start the next round
    func startRound() {
        // Hide the "Next Round" button
        showNextRoundUI(false)
        // Update the events buttons descriptions
        updateEventsUI()
        
        // Start the countdown timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] (t) in
            self.game.secondsLeftForRound -= 1
            self.updateTimerUI()
            
            // If the round timed out, check the answer
            if self.game.roundTimedOut() {
                self.checkEvents()
            }
        })
        
        updateTimerUI()
    }
    
    /// Update the UI for the event buttons to match the Game state
    func updateEventsUI() {
        for index in 0..<eventButtons.count {
            let eventButton = eventButtons[index]
            let event = game.eventsForCurrentRound[index]
            var description = event.description
            if helpMode {
                let dateStr = dateFormatter.string(from: event.date)
                description = "\(event.description) \(dateStr)"
            }
            eventButton.setTitle(description, for: .normal)
        }
    }
    
    /// Update the UI to show the amount of time left for the current round.
    func updateTimerUI() {
        // Make seconds zero padded
        let secondsStr = String(format: "%02d", game.secondsLeftForRound)
        self.timeLabel.text = "0:\(secondsStr)"
    }
    
    /// Check if the events are in the correct order
    func checkEvents() {
        // Stop the current timer from running
        if let t = timer {
            t.invalidate()
        }
        
        // Check if the events are in the correct order
        let correct = game.checkEvents()
        
        // If this was the last round, show the "Game Over" screen,
        // otherwise show the "Next Round" button so the user can see if they got the answer correct.
        if game.gameOver() {
            performSegue(withIdentifier: "gameOver", sender: nil)
        } else {
            showNextRoundUI(true)
            
            if correct {
                nextRoundButton.setBackgroundImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            } else {
                nextRoundButton.setBackgroundImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            }
        }
    }
    
    /// Update the UI to show/hide the "Next Round" button and any other UI changes.
    func showNextRoundUI(_ show: Bool) {
        nextRoundButton.isHidden = !show
        timeLabel.isHidden = show
        if show {
            tipLabel.text = "Tap events to learn more"
        } else {
            tipLabel.text = "Shake to complete"
        }
    }
}

