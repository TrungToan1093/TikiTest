//
//  ErrorAlertManager.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlertManager {
    static let shared = ErrorAlertManager()
    var isShowing = false
    
    func showErrorAlert(title: String, message: String, defaultHandler: (()-> Void)? = nil) {
        if isShowing { return }
        isShowing = true
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.isShowing = false
            alert.dismiss(animated: false)
            defaultHandler?()
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

