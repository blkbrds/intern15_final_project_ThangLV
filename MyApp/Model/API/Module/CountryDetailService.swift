//
//  HomeService.swift
//  MyApp
//
//  Created by Chinh Le on 2/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class CountryDetailService {

    class func loadFoods(at country: String, completion: @escaping Completion) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(country)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else {
                if let data = data {
                    var foods: [Food] = []
                    let json = data.toJSObject()
                    let meals = json["meals"] as? JSONArray ?? []

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
