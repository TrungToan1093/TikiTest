//
//  UILabel+Ext.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/14/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import UIKit

extension UILabel {
    func  setTextWithTwoLine(text: String) {
        DispatchQueue.init(label: "tiki.loading.text", qos: .utility).async {
            let text = Utility.wrapTwoLine(text: text)
            DispatchQueue.main.async {
                self.text = text
            }
        }
    }
}
