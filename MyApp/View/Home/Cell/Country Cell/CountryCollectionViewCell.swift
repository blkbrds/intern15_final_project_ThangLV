//
//  CountryCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 2/26/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CountryCollectionViewCell: CollectionCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var countryImageView: UIImageView!
    @IBOutlet private weak var countryNameLabel: UILabel!
    
    var viewModel = CountryCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Override functions
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    private func updateView() {
        countryNameLabel.text = viewModel.countryName
        countryImageView.image = viewModel.countryImage
    }
}
