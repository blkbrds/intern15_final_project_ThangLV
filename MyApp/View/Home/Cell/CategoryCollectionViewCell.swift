//
//  CategoryCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CategoryCollectionViewCell: CollectionCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryDescriptionLabel: UILabel!    
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        layer.cornerRadius = 10
        clipsToBounds = true
        configImageView()
    }
    
    // MARK: - Private functions
    private func configImageView() {
        categoryImageView.layer.masksToBounds = false
        categoryImageView.layer.cornerRadius = 10
        categoryImageView.clipsToBounds = true
    }
    
    func updateData(category: Category) {
        categoryNameLabel.text = category.categoryName
        categoryDescriptionLabel.text = category.categoryDescription
    }
    
    func updateData2(image: UIImage?) {
        categoryImageView.image = image
    }
}
