//
//  CategoryCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

final class CategoryCollectionViewCell: CollectionCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryDescriptionLabel: UILabel!
    @IBOutlet private weak var infoView: UIView!
    
    var viewModel = CategoryCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configImageView()
        setupUI()
    }

    // MARK: - Private functions
    private func configImageView() {
        categoryImageView.layer.masksToBounds = false
        categoryImageView.layer.cornerRadius = 20
        categoryImageView.clipsToBounds = true
    }
    
    private func updateView() {
        categoryNameLabel.text = viewModel.categoryName
        categoryDescriptionLabel.text = viewModel.categoryDescription
        categoryImageView.sd_setImage(with: URL(string: viewModel.categoryImageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    private func setupUI() {
        infoView.layer.masksToBounds = false
        infoView.layer.cornerRadius = 10
        infoView.clipsToBounds = true
    }
}
