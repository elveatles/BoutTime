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
    let dateFormatter = DateFormatter()
    
    var game: Game!
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
        game.start()
        updateEventsUI()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        checkEvents()
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
        showNextRoundUI(false)
        updateEventsUI()
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
    
    /// Check if the events are in the correct order
    func checkEvents() {
        let correct = game.checkEvents()
        
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

