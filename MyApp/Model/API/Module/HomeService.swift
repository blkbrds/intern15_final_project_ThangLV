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
        let urlString = Api.Path.Home.categoryPath
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else {
                if let data = data {
                    var categories: [Category] = []
                    let json = data.toJSObject()
                    guard let jsCategories = json["categories"] as? JSONArray else { return }
                    for item in jsCategories {
                        let category = Category(json: item)
                        categories.append(category)
                    }
                    completion(.success(categories))
                } else {
                    if let error = error {
                        completion(.failure(error.localizedDescription))
                    }
                }
            }
        }
    }

    class func loadCountries(completion: @escaping Completion) {
        let urlString = Api.Path.Home.countryPath
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    guard let meals = json["meals"] as? JSONArray else { return }
                    var countries: [Country] = []

                    for item in meals {
                        let country = Country(json: item)
                        countries.append(country)
                    }
        
                    completion(.success(countries))
                } else {
                    if let error = error {
                        completion(.failure(error.localizedDescription))
                    }
                }
            }
        }
    }
}
