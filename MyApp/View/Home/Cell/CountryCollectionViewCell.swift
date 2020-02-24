//
//  CountryCollectionViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CountryCollectionViewCell: CollectionCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet private weak var countryNameLabel: UILabel!
    
    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(name: String, image: UIImage) {
        countryNameLabel.text = name
        countryImageView.image = image
    }
}
