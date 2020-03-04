//
//  HomeViewModel .swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import MVVM

@available(iOS 11.0, *)
final class HomeViewModel: ViewModel {

    // MARK: - Properties
    let countryNames: [String] = ["American", "British", "Canadian", "Chinese", "Dutch", "Egyptian", "French", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Russian", "Spanish", "Thai", "Tunisian", "Turkish", "Unknown", "Vietnamese"]
    var countries: [Country] = []
    private var categories: [Category] = []

    func getCategories(at indexPath: IndexPath? = nil, success: @escaping Success) {
        HomeService.loadCategories() { result in
            switch result {
            case .success(let categories):
                if let categories = categories as? [Category] {
                    self.categories = categories
                    success(true, categories[indexPath?.row ?? 0].categoryThumb)
                }
            case .failure(let message):
                success(false, message)
            }
        }
    }

    func getCountries(at indexPath: IndexPath? = nil, success: @escaping Success) {
        HomeService.loadCountries() { result in
            switch result {
            case .success(let countries):
                if let countries = countries as? [Country] {
                    self.countries = countries
                    success(true, "")
                }
            case .failure(let message):
                success(false, message)
            }
        }
    }

    func numberOfItems(isCountry: Bool, inSection section: Int) -> Int {
        if isCountry {
            return countries.count
        } else {
            return categories.count
        }
    }

    func countryName(at indexPath: IndexPath) -> String {
        return countries[indexPath.row].name
    }

    func categoryName(at indexPath: IndexPath) -> String {
        return categories[indexPath.row].categoryName
    }

    func categoryThumb(at indexPath: IndexPath) -> String {
        return categories[indexPath.row].categoryThumb
    }

    func categoryImage(at indexPath: IndexPath) -> UIImage {
        return categories[indexPath.row].categoryImage ?? UIImage()
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> CountryCollectionCellViewModel {
        let countryName = countries[indexPath.row].name
        return CountryCollectionCellViewModel(countryName: countryName)
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> CategoryCollectionCellViewModel {
        let categoryName = categories[indexPath.row].categoryName
        let categoryDescription = categories[indexPath.row].categoryDescription
        let categoryImageUrl = categories[indexPath.row].categoryThumb
        
        return CategoryCollectionCellViewModel(categoryImageUrl: categoryImageUrl,categoryName: categoryName, categoryDescription: categoryDescription)
    }
}





