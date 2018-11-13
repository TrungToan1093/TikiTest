//
//  Products.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation

struct Products: Codable {
    let keywords: [Product]
}

struct Product: Codable {
    let keyword: String
    let icon: URL
    var hexStringColor: String?
}
