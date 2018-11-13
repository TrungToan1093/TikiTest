//
//  Environment.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
enum Environment: String {
    case debug
    case staging
    
    var baseURL: String {
        switch self {
        case .debug:      return "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com"
        case .staging:    return ""
        }
    }
}


