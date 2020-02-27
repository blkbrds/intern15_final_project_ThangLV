//
//  CustomCollectionViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: CollectionCell {

    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        layer.masksToBounds = false
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    var viewModel = CustomCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        foodNameLabel.text = viewModel.foodName
    }
    
    func loadImage() -> UIImageView {
        return foodImageView
    }
}
