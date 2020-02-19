//
//  HomeViewModel .swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

typealias Completion = (Bool, String) -> Void

@available(iOS 11.0, *)
final class HomeViewModel {
    // MARK: - Properties
    let countryNames: [String] = ["American", "British", "Canadian", "Chinese", "Dutch", "Egyptian", "French", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Russian", "Spanish", "Thai", "Tunisian", "Turkish", "Unknown", "Vietnamese"]
    var countries: [Country] = []
    var categories: [Category] = []
    
    //MARK: - Load API functions
    func loadAPI(completion: @escaping Completion) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    let jsCategories = json["categories"] as? [JSON] ?? []
                    for item in jsCategories {
                        let category = Category(json: item)
                        self.categories.append(category)
                        
                        completion(true, "")
                    }
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
    
    func loadAPI2(completion: @escaping Completion) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        Networking.shared().request(with: urlString) { (data, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                if let data = data {
                    let json = data.toJSObject()
                    let meals = json["meals"] as? [JSON] ?? []
                    print(meals)
                    for item in meals {
                        let country = Country(json: item)
                        self.countries.append(country)
                        
                        completion(true, "")
                    }
                } else {
                    completion(false, "Data format is error.")
                }
            }
        }
    }
}
