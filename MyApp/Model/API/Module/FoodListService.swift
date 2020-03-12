//
//  FoodListService.swift
//  MyApp
//
//  Created by Chinh Le on 2/26/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class FoodListService {
    
    class func loadFoods(at categoryName: String = "", completion: @escaping Completion) {
        let urlString = Api.Path.FoodList(categoryName: categoryName).path
        
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    guard let meals = json["meals"] as? JSONArray else {
                        completion(.failure(error!.localizedDescription))
                        return
                    }
                    var foods: [Food] = []
                    
                    for item in meals {
                        let food = Food(json: item)
                        foods.append(food)
                    }
                    completion(.success(foods))
                } else {
                    if let error = error {
                        completion(.failure(error.localizedDescription))

                    }
                }
            }
        }
    }
}
