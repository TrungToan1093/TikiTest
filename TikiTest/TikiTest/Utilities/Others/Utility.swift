//
//  Utility.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import UIKit

struct Utility {
    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    static func widthForViewWithTwoLines(text:String, font:UIFont, height:CGFloat) -> CGFloat{
        let textMod = wrapTwoLine(text: text)
        let label:UILabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = textMod
        label.textAlignment = .center
        label.sizeToFit()
        return label.frame.width
    }
    
    static func wrapTwoLine(text: String) -> String{
        let indexCenter = text.replaceNewlinesToWhitespaces.count / 2
        var indexCenterTemp = indexCenter
        var textTemp = text.replaceNewlinesToWhitespaces
        if textTemp.contains(" ") {
            while (indexCenterTemp != 1 && textTemp[indexCenterTemp] != " ")  {
                indexCenterTemp -= 1
            }
            if indexCenterTemp == 1 {
                indexCenterTemp = indexCenter
                while textTemp[indexCenterTemp + 1] != " "{
                    indexCenterTemp += 1
                }
            }
            textTemp = text.replace(indexCenter, "\n")
        }
        return textTemp
    }
}
