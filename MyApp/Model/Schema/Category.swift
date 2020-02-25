//
//  Category.swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error"
        }
    }
}

final class Category {
    var idCategory: String
    var categoryName: String
    var categoryThumb: String
    var categoryDescription: String
    var categoryImage: UIImage?
    
    init(json: JSONObject) {
        idCategory = json["idCategory"] as? String ?? ""
        categoryName = json["strCategory"] as? String ?? ""
        categoryThumb = json["strCategoryThumb"] as? String ?? ""
        categoryDescription = json["strCategoryDescription"] as? String ?? ""
    }
}
