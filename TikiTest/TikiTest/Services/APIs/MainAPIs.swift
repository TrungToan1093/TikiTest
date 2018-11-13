//
//  MainAPIs.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import  Alamofire
import PromiseKit

protocol MainAPIsService {
    var network: Networking { get }
    
    func getProducts() -> Promise<Products>
}

enum MainAPIsTarget {
    case getProducts()
}

extension MainAPIsTarget: TargetType {
    var path: String {
        return "ios/keywords.json"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts():
            return .get
        }
    }
    
    var parameters: Parameters? {
        return [:]
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getProducts():
            return URLEncoding.default
        }
    }
}

struct MainAPIs: MainAPIsService {
    
    var network: Networking
    var configuration: Configuration
    
    func getProducts() -> Promise<Products> {
        return network.dataRequest(target: MainAPIsTarget.getProducts(), configuration: configuration)
    }
    
}

