//
//  IngredientsTableCellViewModel'.swift
//  MyApp
//
//  Created by Chinh Le on 3/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class IngredientsTableCellViewModel {
    var ingredientMass: String
    var ingredientName: String
    
    init(ingredientMass: String = "", ingredientName: String = "") {
        self.ingredientMass = ingredientMass
        self.ingredientName = ingredientName
    }
}
