//
//  HomeService.swift
//  MyApp
//
//  Created by PCI0008 on 2/27/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class CountryDetailService {

    class func loadFoods(at country: String, completion: @escaping Completion) {
        let urlString = Api.Path.CountryDetail(countryName: country).path
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
