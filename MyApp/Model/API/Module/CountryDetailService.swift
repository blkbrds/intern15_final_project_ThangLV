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
        let urlString = "\(Api.Path.CountryDetail.path)\(country)"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else {
                if let data = data {
                    var foods: [Food] = []
                    let json = data.toJSObject()
                    guard let meals = json["meals"] as? JSONArray else { return }

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
