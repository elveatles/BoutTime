//
//  Event.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/25/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Represents an event in history
struct Event: Equatable {
    /// The description of the event
    let description: String
    /// The date the event occurred.
    let date: Date
    /// A URL for more information about the event.
    let url: String
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.date == rhs.date && lhs.description == rhs.description
    }
}
