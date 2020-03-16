//
//  SearchService.swift
//  MyApp
//
//  Created by PCI0008 on 3/3/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class SearchService {
    class func loadFoods(with keyword: String, completion: @escaping Completion) {
        guard let keywordEncoding = keyword.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            completion(.failure("API link error."))
            return
        }
        
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(keywordEncoding)"
        
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    let meals = json["meals"] as? JSONArray ?? []
                    var foods: [Food] = []

                    for item in meals {
                        let food = Food(json: item)
                        foods.append(food)
                    }

                    completion(.success(foods))
                } else {
                    completion(.failure("API error."))
                }
            }
        }
    }
}
