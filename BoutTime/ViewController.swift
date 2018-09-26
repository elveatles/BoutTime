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
    
    var game: Game!
    var eventButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        eventButtons = [eventButton0, eventButton1, eventButton2, eventButton3]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        game = appDelegate.game
        game.start()
        updateEventsUI()
    }
    
    /// Update the UI for the event buttons to match the Game state
    func updateEventsUI() {
        for index in 0..<eventButtons.count {
            let eventButton = eventButtons[index]
            let event = game.eventsForCurrentRound[index]
            eventButton.setTitle(event.description, for: .normal)
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
}

