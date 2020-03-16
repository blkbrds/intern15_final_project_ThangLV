//
//  SearchCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 3/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 11.0, *)
final class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    
    var viewModel = SearchCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.masksToBounds = false
        layer.cornerRadius = 15
        clipsToBounds = true
        foodNameLabel.numberOfLines = 3
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodNameLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            foodNameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            foodNameLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            foodNameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            ])
    }
    
    private func updateView() {
        foodImageView.sd_setImage(with: URL(string: viewModel.foodImageURL), placeholderImage: UIImage(named: "placeholder.png"))
        foodNameLabel.text = viewModel.foodName
    }
}
