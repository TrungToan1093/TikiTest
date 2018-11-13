//
//  ErrorResponse.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation

struct ErrorResponse: Error {
    public var code: String?
    public var message: String?
}

struct TAPIsError: Codable, Error {
    var Message: String?
}
