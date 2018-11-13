//
//  NSObjective+Ext.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation

extension NSObject {
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}
