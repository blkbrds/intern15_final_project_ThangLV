//
//  FavoriteTableCellViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 3/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class FavoriteTableCellViewModel {
    var foodImageURL: String
    var foodName: String
    var categoryName: String
    var countryName: String
    
    init(foodImageURL: String = "", foodName: String = "", categoryName: String = "", countryName: String = "") {
        self.foodImageURL = foodImageURL
        self.foodName = foodName
        self.categoryName = categoryName
        self.countryName = countryName
    }
}
