//
//  Sring+Ext.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/14/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    func replace( _ index: Int, _ newChar: Character) -> String {
        var chars = Array(self)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    var replaceNewlinesToWhitespaces: String {
        return components(separatedBy: .whitespacesAndNewlines).joined(separator: " ")
    }
}
