//
//  FavoriteTableViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 3/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

final class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var infoView: UIView!
    
    
    var viewModel = FavoriteTableCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        foodNameLabel.numberOfLines = 3
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodNameLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            foodNameLabel.topAnchor.constraint(equalTo: infoView.layoutMarginsGuide.topAnchor),
            foodNameLabel.trailingAnchor.constraint(equalTo: infoView.layoutMarginsGuide.trailingAnchor),
            foodNameLabel.leadingAnchor.constraint(equalTo: infoView.layoutMarginsGuide.leadingAnchor),
            ])
        foodImageView.layer.masksToBounds = false
        foodImageView.layer.cornerRadius = foodImageView.frame.width / 2
        foodImageView.clipsToBounds = true
        
        infoView.layer.masksToBounds = false
        infoView.layer.cornerRadius = 15
        infoView.clipsToBounds = true
    }
        
    private func updateView() {
        foodNameLabel.text = viewModel.foodName
        categoryNameLabel.text = viewModel.categoryName
        countryNameLabel.text = viewModel.countryName
        foodImageView.sd_setImage(with: URL(string: viewModel.foodImageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
