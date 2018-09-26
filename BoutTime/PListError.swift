//
//  PListError.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/25/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Errors related to plists
enum PListError: Error {
    /// If the resource does not exist
    case invalidResource
    /// If the plist cannot be converted into a Swift type
    case conversionFailure
}
