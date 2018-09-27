//
//  SoundError.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/27/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Error related to so sounds
enum SoundError: Error {
    /// The resource does not exist
    case invalidResource
    /// Could not initialize an audio player
    case unableToLoad
}
