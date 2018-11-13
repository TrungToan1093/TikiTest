//
//  AppAssembler.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import UIKit
class AppAssembler {
    //UIWindown
    func resolve() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    //  Environment
    func resolve() -> Environment {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "ConfigurationMode") as? String {
            if configuration == "debug" {
                return Environment.debug
            }
        }
        return Environment.staging
    }
    
     // RESTful service
    func resolve() -> AppConfiguration {
        let env: Environment = resolve()
        return AppConfiguration(baseURL: env.baseURL)
    }
    
    func resolve() -> MainAPIsService {
        let config: AppConfiguration = resolve()
        return MainAPIs(network: resolve(), configuration: config)
    }
    
    func resolve() -> Networking {
        return Network()
    }
    
    //MainVC
    func resolve() -> MainViewController {
        let viewModel : MainViewModel = appAssembler.resolve()
        return MainViewController(viewModel: viewModel)
    }
    
    //MainModel
    func resolve() -> MainViewModel {
        return MainViewModel(mainService: resolve())
    }
}

