//
//  AppDelegate.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import UIKit
import RealmSwift
import Fabric
import Crashlytics

let appAssembler = AppAssembler()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        SyncManager.shared.logLevel = .off

        self.window = appAssembler.resolve()
        
        let mainVC : MainViewController = appAssembler.resolve()
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

