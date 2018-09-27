//
//  Game.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/25/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A class that manages all of the logic of a game.
class Game {
    /// All possible events that can be used for the rounds
    let allEvents: [Event]
    /// The number of rounds for each game
    let numRounds = 6
    /// The number of events for a single round
    let eventsPerRound = 4
    /// The total number of seconds for each round
    let totalSecondsPerRound = 60
    /// The current round number
    var currentRound = 1
    /// The number of rounds that were correct
    var numCorrect = 0
    /// The number of seconds that are left for the current round
    var secondsLeftForRound = 60
    /// Flag if the current round has been checked
    var currentRoundChecked = false
    /// The events for the current round
    var eventsForCurrentRound: [Event] = []
    
    /// Loads all events from Events.plist
    /// A fatal error occurs if the events cannot be loaded.
    /// Without the events, it's not possible to play the game.
    init() {
        do {
            let arr = try PListConverter.array(forResource: EventsUnarchiver.plistName, ofType: "plist")
            allEvents = try EventsUnarchiver.events(fromArray: arr)
        } catch PListError.invalidResource {
            fatalError("Could not find 'Events' plist.")
        } catch PListError.conversionFailure {
            fatalError("Could not convert 'Events' plist into an array.")
        } catch EventError.unexpectedData(let message) {
            let fullMessage = "Could not convert 'Events' from [AnyObject] to [Event]. \(message)"
            fatalError(fullMessage)
        } catch let error {
            fatalError("\(error)")
        }
    }
    
    /// Start a new game.
    func newGame() {
        currentRound = 1
        numCorrect = 0
        setupCurrentRound()
    }
    
    /// Setup the events for the current round.
    func setupCurrentRound() {
        eventsForCurrentRound = []
        
        // Check that there are enough events to choose from.
        // Can't play the game otherwise, so create a fatal error.
        if allEvents.count < eventsPerRound {
            fatalError("Game.setupCurrentRound: Game.allEvents must contain at least \(eventsPerRound) events.")
        }
        
        currentRoundChecked = false
        secondsLeftForRound = totalSecondsPerRound
        
        // Pick random events for the current round
        var indexesUsed: [Int] = []
        while indexesUsed.count < eventsPerRound {
            let randomIndex = Int.random(in: 0..<allEvents.count)
            guard !indexesUsed.contains(randomIndex) else {
                continue
            }
            
            let randomEvent = allEvents[randomIndex]
            eventsForCurrentRound.append(randomEvent)
            indexesUsed.append(randomIndex)
        }
    }
    
    /**
     Swap events for the current round.
     
     - Parameter index1: The first index to swap.
     - Parameter index2: The second index to swap.
    */
    func swapEvents(index1: Int, index2: Int) {
        let temp = eventsForCurrentRound[index1]
        eventsForCurrentRound[index1] = eventsForCurrentRound[index2]
        eventsForCurrentRound[index2] = temp
    }
    
    /// Check if the order of events for the current round are correct.
    /// - Returns: true if the events are in correct order chronologically.
    func checkEvents() -> Bool {
        let sortedEvents = eventsForCurrentRound.sorted { (event1, event2) -> Bool in
            return event1.date < event2.date
        }
        
        let result = sortedEvents == eventsForCurrentRound
        if !currentRoundChecked && result {
            numCorrect += 1
        }
        
        currentRoundChecked = true
        
        return result
    }
    
    
    /// Check if the current round timed out
    /// - Returns: true if the current round timed out.
    func roundTimedOut() -> Bool {
        return secondsLeftForRound <= 0
    }
    
    /// Check if the game is over -- all rounds have been played.
    func gameOver() -> Bool {
        return currentRound >= numRounds
    }
}
