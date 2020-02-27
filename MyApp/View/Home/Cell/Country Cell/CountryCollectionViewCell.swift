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
    
    var viewModel = CountryCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateView() {
        countryNameLabel.text = viewModel.countryName
        countryImageView.image = UIImage(named: viewModel.countryName)
    }
}
