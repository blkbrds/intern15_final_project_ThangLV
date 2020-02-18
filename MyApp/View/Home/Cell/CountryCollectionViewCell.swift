//
//  CountryCollectionViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: CollectionCell {
    // MARK: - IBOutlets
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    func configData(image: UIImage?) {
        countryImageView.image = image
    }
}
