//
//  CategoryCollectionView.swift
//  MyApp
//
//  Created by PCI0008 on 2/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CategoryCollectionView: UICollectionView {
    override func awakeFromNib() {
        configCategoryCollectionView()
    }
    
    private func configCategoryCollectionView() {
        let categoryCollectionViewCellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        register(categoryCollectionViewCellNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
}

