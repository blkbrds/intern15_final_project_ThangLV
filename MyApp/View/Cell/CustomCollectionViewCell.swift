//
//  CustomCollectionViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: CollectionCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(foodName: String? = nil, foodImage: UIImage? = nil) {
        foodNameLabel.text = foodName
        foodImageView.image = foodImage
    }
}
