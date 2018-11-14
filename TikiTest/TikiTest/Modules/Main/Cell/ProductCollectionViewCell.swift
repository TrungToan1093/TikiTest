//
//  ProductCollectionViewCell.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productView: UIImageView!
    @IBOutlet weak var keyworkLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configView(product: Product)  {
        self.productView.setImageWithURL(url: product.icon)
        self.keyworkLabel.setTextWithTwoLine(text: product.keyword)
        self.keyworkLabel.layer.masksToBounds = true
        self.keyworkLabel.layer.cornerRadius = 5
        self.keyworkLabel.backgroundColor = UIColor.hexStringToUIColor(hex: product.hexStringColor!)
    }
}

