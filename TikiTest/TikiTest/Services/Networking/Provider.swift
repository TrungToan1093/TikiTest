//
//  Provider.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import Alamofire

public enum Task {
    case request
    case upload
    case download
}

public protocol TargetType {
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool { get }
    
    /// The headers to be used in the request.
    var defaultHeaders: HTTPHeaders { get } //[String:String]
    
    var headers: HTTPHeaders? { get } //[String:String]
    
    
    var parameters: Parameters? { get } // [String: Any]
    
    var encoding: ParameterEncoding { get }
    
    var keyPath: String? { get }
    
     var globalAlert: Bool { get }
}

extension TargetType {
    var task: Task {
        return .request
    }
    
    var validate: Bool {
        return false
    }
    
    var defaultHeaders: HTTPHeaders {
        return [:]
    }
    
    var keyPath: String? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var globalAlert: Bool {
        return true
    }
}

public protocol Configuration {
    var baseURL: String { get }
}

public extension Configuration {
    public var baseURL: String {
        let env: Environment = appAssembler.resolve()
        return env.baseURL
    }
}

public struct AppConfiguration: Configuration {
    public var baseURL: String
}

