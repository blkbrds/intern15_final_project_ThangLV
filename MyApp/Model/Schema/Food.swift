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
    var imageURL: String
    var cookingVideoURL: String
    var ingredients: [String] = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var measures: [String] = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    init(json: JSONObject) {
        foodName = json["strMeal"] as? String ?? ""
        categoryName = json["strCategory"] as? String ?? ""
        countryName = json["strArea"] as? String ?? ""
        cookingInstruction = json["strInstructions"] as? String ?? ""
        imageURL = json["strMealThumb"] as? String ?? ""
        cookingVideoURL = json["strYoutube"] as? String ?? ""
        for i in 0...19 {
            ingredients[i] = json["strIngredient\(i + 1)"] as? String ?? ""
        }
        for j in 0...19 {
            measures[j] = json["strMeasure\(j + 1)"] as? String ?? ""
        }
    }
}
