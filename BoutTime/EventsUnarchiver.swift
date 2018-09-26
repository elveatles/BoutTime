//
//  EventsUnarchiver.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/25/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Converts raw data to the Event model
class EventsUnarchiver {
    /// The name of the plist that contains the events
    static let plistName = "Events"
    
    /**
     Convert an Array with raw data into an Array of Events.
     
     - Parameter objectArray: The array to convert. Probably from a plist.
     - Throws: `EventError.unexpectedData`
                if the items in the array aren't dictionaries
                or if each item does not have a "description", "date", and "url".
    */
    static func events(fromArray objectArray: [AnyObject]) throws -> [Event] {
        var result: [Event] = []
        
        for item in objectArray {
            guard let dict = item as? [String: Any] else {
                throw EventError.unexpectedData("Array item could not be converted to a dictionary: \(item)")
            }
            
            guard let description = dict["description"] as? String, let date = dict["date"] as? Date, let url = dict["url"] as? String else {
                throw EventError.unexpectedData("Array item does not contain a description, date, or url: \(item)")
            }
            
            let event = Event(description: description, date: date, url: url)
            result.append(event)
        }
        
        return result
    }
}
