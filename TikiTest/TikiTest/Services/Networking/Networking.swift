//
//  Networking.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

public protocol Networking {
    func dataRequest<T: Codable>(target: TargetType, configuration: Configuration) -> Promise<T>
}


extension Networking {
    fileprivate func prepareHeader(target: TargetType, configuration: Configuration) -> HTTPHeaders {
        var headers =  target.defaultHeaders
        if let optionHeaders = target.headers {
            for (key, value) in optionHeaders {
                headers.updateValue(value, forKey: key)
            }
        }
        return headers
    }
    
    func dataRequest<T:Codable>(target: TargetType, configuration: Configuration) -> Promise<T> {
        return Promise<T> { seal in
            let endPointURL = URL(string: configuration.baseURL)!
            let url = endPointURL.appendingPathComponent(target.path)
            
            let params: [String: Any] = target.parameters ?? [:]
            let method = target.method
            let headers = self.prepareHeader(target: target, configuration: configuration)
            let encoding = target.encoding
            
            print("Request with target \n -> URL: \(url) \n -> Method: \(method) \n -> Params:  \(String(describing: params))\n -> Header: \(headers) \n -> Encoding: \(encoding)")
            Alamofire.request(url,
                              method: method,
                              parameters: params,
                              encoding: encoding,
                              headers: headers)
                .validate()
                .responseJSON { response in
                    if let error = response.error as NSError? {
                        print("Request \(String(describing: response.request)) error :\(error.localizedDescription)")
                    }
                    
                    guard let statusCode = response.response?.statusCode else {
                        let error = ErrorResponse(code: "-1", message: "Could not get status code")
                        seal.reject(error)
                        return
                    }
                    
                    guard let jsonValue = response.result.value else {
                        let error = TAPIsError(Message: "Could not get JSON value")
                        if target.globalAlert {
                            ErrorAlertManager.shared.showErrorAlert(title: "\(statusCode)", message: error.Message ?? "")
                        }
                        seal.reject(error)
                        return
                    }
                    
                    guard let dataJSON = try? JSONSerialization.data(withJSONObject: jsonValue) else {
                        let error = TAPIsError(Message: "Could not parse data")
                        if target.globalAlert {
                            ErrorAlertManager.shared.showErrorAlert(title: "\(statusCode)", message: error.Message ?? "")
                        }
                        seal.reject(error)
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    if let data = try? decoder.decode(T.self, from: dataJSON ) {
                        seal.fulfill(data)
                    } else {
                        let error = TAPIsError(Message: "Could not parse data")
                        if target.globalAlert {
                            ErrorAlertManager.shared.showErrorAlert(title: "\(statusCode)", message: error.Message ?? "")
                        }
                        seal.reject(error)
                    }
                    
            }
        }
    }
}

class Network: Networking {
    
}


