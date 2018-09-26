//
//  PListConverter.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/25/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Converts plists into a Arrays
class PListConverter {
    
    /**
     Create an Array from a plist.
     
     - Parameter name: The name of the plist resource.
     - Parameter ext: The extension of the resource file.
     - Throws: `PListError.invalidResource`
                if a resource with name and ext does not exist.
     - Throws: `PListError.conversionFailer`
                if the plist cannot be converted into an Array.
     - Returns: The plist converted to an Array.
    */
    static func array(forResource name: String, ofType ext: String) throws -> [AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: ext) else {
            throw PListError.invalidResource
        }
        
        guard let result = NSArray(contentsOfFile: path) as [AnyObject]? else {
            throw PListError.conversionFailure
        }
        
        return result
    }
}
