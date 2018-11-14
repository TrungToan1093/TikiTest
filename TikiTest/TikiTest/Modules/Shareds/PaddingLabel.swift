//
//  PaddingLabel.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/14/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import UIKit
class PaddingLabel: UILabel {
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//    }
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        return CGSize(width: originalContentSize.width , height: originalContentSize.height)
    }
}
