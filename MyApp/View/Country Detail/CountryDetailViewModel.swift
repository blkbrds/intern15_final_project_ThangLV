//
//  CountryDetailViewModel.swift
//  MyApp
//
//  Created by Chinh Le on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class CountryDetailViewModel {
    var foods: [Food] = []
    var countryName: String = ""
    
    func loadAPI(completion: @escaping Completion) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(countryName)"
        
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    let meals = json["meals"] as? JSONArray ?? []
                    
                    for item in meals {
                        let food = Food(json: item)
                        self.foods.append(food)
                    }
                    completion(true, "")
                } else {
                    completion(false, "Data format is error")
                }
            }
        }
    }
    
    func loadImage(at indexPath: IndexPath, completion: @escaping (Bool, String) -> Void) {
        let food = foods[indexPath.row]
        Networking.shared().downloadImage(url: food.imageUrl) { (image) in
            if let image = image {
                self.foods[indexPath.row].foodImage = image
                completion(true, "")
            } else {
                completion(false, "")
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return foods.count
    }
}
