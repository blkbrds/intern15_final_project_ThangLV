//
//  Food.swift
//  MyApp
//
//  Created by Chinh Le on 2/22/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class Food {
    var foodImage: UIImage?
    var foodName: String
    var categoryName: String
    var countryName: String
    var cookingInstruction: String
    var imageUrl: String
    
    init(json: JSONObject) {
        foodName = json["strMeal"] as? String ?? ""
        categoryName = json["strCategory"] as? String ?? ""
        countryName = json["strArea"] as? String ?? ""
        cookingInstruction = json["strInstructions"] as? String ?? ""
        imageUrl = json["strMealThumb"] as? String ?? ""
    }
}
