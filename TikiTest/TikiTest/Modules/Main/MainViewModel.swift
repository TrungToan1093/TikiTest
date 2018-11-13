//
//  MainModel.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

final class MainViewModel: NSObject {
    
    let mainService : MainAPIsService
    
    var productsFilter : Variable<[Product]> = Variable<[Product]>([])
    var firstProducts: [Product] = []
    
    var history : Variable<[History]> = Variable<[History]>([])
    var realm: Realm!
    var histories : Results<History>?
    var historiesToken: NotificationToken?
    let listHexStringBackgroundColors: [String] = ["#16702e","#005a51","#996c00","#5c0a6b","#006d90","#974e06","#99272e","#89221f","#00345d"]
    var numberOfItemsHotKey: Int {
        return self.productsFilter.value.count
    }
    
    var numberOfItemsHistory: Int {
        return self.histories?.count ?? 0
    }
    
    init(mainService: MainAPIsService){
        self.mainService = mainService
        super.init()
        self.setupRealm()
    }
    
    func getProducts() {
        mainService.getProducts().done { [weak self] response in
            guard let this = self else { return }

            let products = response.keywords.enumerated().map({ (index, product) -> Product in
                let product = Product(keyword: product.keyword, icon: product.icon, hexStringColor: this.listHexStringBackgroundColors[index % this.listHexStringBackgroundColors.count])
                return product
            })
            this.firstProducts = products
            this.productsFilter.value = products
            }.catch { (error) in
                print("getProducts error: \(error)")
        }
    }

    
    //MARK: Realm
    private func setupRealm() {
        let realm = try! Realm()
        guard realm.isEmpty else {
            histories = History.all(in: realm)
            return
        }
        self.realm = realm
        histories = History.all(in: realm)
        print("Realm path: \(String(describing: realm.configuration.fileURL))")
    }
    
    func addHistory(history: History) {
        History.add(history: history)
    }
    
    func deleteHistory() {
        History.deleteAll(objects: self.histories!)
    }

}
