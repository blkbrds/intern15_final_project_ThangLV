//
//  CategoryCollectionCellViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 2/26/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CategoryCollectionCellViewModel {
    var categoryImageUrl: String
    var categoryName: String
    var categoryDescription: String
    
    init(categoryImageUrl: String = "", categoryName: String = "", categoryDescription: String = "") {
        self.categoryImageUrl = categoryImageUrl
        self.categoryName = categoryName
        self.categoryDescription = categoryDescription
    }
}
