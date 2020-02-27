//
//  HomeService.swift
//  MyApp
//
//  Created by PCI0008 on 2/26/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class HomeService {
    
    //MARK: - Load API functions
    class func loadCategories(completion: @escaping Completion) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        Networking.shared().request(with: urlString) { (data, error) in
            if error != nil {
                completion(.failure("API error."))
            } else {
                if let data = data {
                    var categories: [Category] = []
                    let json = data.toJSObject()
                    let jsCategories = json["categories"] as? JSONArray ?? []
                    for item in jsCategories {
                        let category = Category(json: item)
                        categories.append(category)
                    }
                    completion(.success(categories))
                } else {
                    completion(.failure("Data format is error."))
                }
            }
        }
    }

    class func loadCountries(completion: @escaping Completion) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        Networking.shared().request(with: urlString) { (data, error) in
            if error != nil {
                completion(.failure("API error."))
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    let meals = json["meals"] as? JSONArray ?? []
                    var countries: [Country] = []

                    for item in meals {
                        let country = Country(json: item)
                        countries.append(country)
                    }
        
                    completion(.success(countries))
                } else {
                    completion(.failure("Data for mat is error."))
                }
            }
        }
    }
}
