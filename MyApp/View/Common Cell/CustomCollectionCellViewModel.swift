//
//  CustomCollectionCellViewModel.swift
//  MyApp
//
//  Created by Chinh Le on 2/26/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CustomCollectionCellViewModel {
    
    var foodName: String
    var imageURL: String
    
    init(foodName: String = "", imageURL: String = "") {
        self.foodName = foodName
        self.imageURL = imageURL
    }
}
