//
//  EventError.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/25/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Errors related to Events
enum EventError: Error {
    /// When raw data cannot be converted into an Event
    case unexpectedData(String)
}
