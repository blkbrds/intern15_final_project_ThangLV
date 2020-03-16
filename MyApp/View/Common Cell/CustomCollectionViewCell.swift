//
//  CustomCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 2/21/18.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

final class CustomCollectionViewCell: CollectionCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!

    var viewModel = CustomCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }

    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private functions
    private func updateView() {
        foodNameLabel.text = viewModel.foodName
        foodImageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(named: "placeholder.png"))
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
}
