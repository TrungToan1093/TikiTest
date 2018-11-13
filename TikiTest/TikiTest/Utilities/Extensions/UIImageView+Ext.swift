//
//  UIImageView+Ext.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImageWithURL(url: URL) {
        DispatchQueue.init(label: "tiki.loading.photo", qos: .background).async {
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { [weak self] (image, error, cacheType, url) in
                guard let this = self  else {
                    return
                }
                guard let image = image else {
                    DispatchQueue.main.async {
                        this.image = #imageLiteral(resourceName: "category-empty")
                    }
                    return
                }
                this.image = image
            })
        }
    }
}
