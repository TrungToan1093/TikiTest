//
//  HUDManager.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import MBProgressHUD

protocol HUDManager {
    var view: UIView! { get }
    func showResponseWaiting()
    func hideResponseWaiting()
}

extension HUDManager {
    func showResponseWaiting() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        hud.tag = ViewTagManager.hub
    }
    
    func hideResponseWaiting() {
        if let hud = view?.viewWithTag(ViewTagManager.hub) as? MBProgressHUD {
            hud.hide(animated: true)
        }
    }
}

class ViewTagManager {
    static let hub = 999
}
