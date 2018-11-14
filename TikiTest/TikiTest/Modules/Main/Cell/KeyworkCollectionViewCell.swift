//
//  KeyworkCollectionViewCell.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import UIKit

class KeyworkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var keyworkLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configView(history: History) {
        self.keyworkLabel.setTextWithTwoLine(text: history.key)
        self.keyworkLabel.layer.masksToBounds = true
        self.keyworkLabel.layer.cornerRadius = 5
        self.keyworkLabel.backgroundColor = UIColor.hexStringToUIColor(hex: history.hexStringColor)
    }
}
