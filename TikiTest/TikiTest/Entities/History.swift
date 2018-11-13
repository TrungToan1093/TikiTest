//
//  History.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import RealmSwift

@objc(History)
@objcMembers class History: Object {
    // MARK: Properties
    enum Property: String {
        case key
        case date
    }
    
    dynamic var key = ""
    dynamic var date =  Date.distantPast
    dynamic var hexStringColor = ""
    
    // MARK: - Init
    convenience init(_ value: String, hexStringColor: String) {
        self.init()
        self.key = value
        self.hexStringColor = hexStringColor
        self.date = Date()
    }
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    override static func indexedProperties() -> [String] {
        return ["date"]
    }
}

extension History {
    static func all(in realm: Realm = try! Realm()) -> Results<History> {
        return realm.objects(History.self).sorted(byKeyPath: History.Property.date.rawValue)
    }
    
    static func add(history: History, in realm: Realm = try! Realm()) {
        if realm.object(ofType: History.self, forPrimaryKey: history.key) == nil {
            try! realm.write {
                realm.add(history)
            }
        }
    }
    
    static func deleteAll(in realm: Realm = try! Realm(), objects: Results<History>) {
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    

}
