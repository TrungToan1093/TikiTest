//
//  UIColor+Ext.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    @nonobjc class var backgroundColor1: UIColor {
        return UIColor(hexString: "#16702e") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor2: UIColor {
        return UIColor(hexString: "#005a51") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor3: UIColor {
        return UIColor(hexString: "#996c00") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor4: UIColor {
        return UIColor(hexString: "#5c0a6b") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor5: UIColor {
        return UIColor(hexString: "#006d90") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor6: UIColor {
        return UIColor(hexString: "#974e06") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor7: UIColor {
        return UIColor(hexString: "#99272e") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor8: UIColor {
        return UIColor(hexString: "#89221f") ?? UIColor.clear
    }
    @nonobjc class var backgroundColor9: UIColor {
        return UIColor(hexString: "#00345d") ?? UIColor.clear
    }    
}

