//
//  FoodDetailViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 2/21/18.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import AVKit
import XCDYouTubeKit

@available(iOS 11.0, *)
final class FoodDetailViewModel {

    // MARK: - Properties
    var foods: [Food] = []
    var similarCountryFoods: [Food] = []
    var similarCategoryFoods: [Food] = []
    var foodName: String = ""
    var country: String = ""
    var category: String = ""

    var countryName: String {
        guard foods.count > 0 else { return "" }
        return foods[0].countryName
    }

    var categoryName: String {
        guard foods.count > 0 else { return "" }
        return foods[0].categoryName
    }

    var foodImageURL: String {
        guard foods.count > 0 else { return "" }
        return foods[0].imageURL
    }

    var cookingInstruction: String {
        guard foods.count > 0 else { return "" }
        return foods[0].cookingInstruction
    }

    var cookingVideoURL: String {
        guard foods.count > 0 else { return "" }
        return foods[0].cookingVideoURL
    }

    // MARK: - init()
    init() { }

    init(foodName: String) {
        self.foodName = foodName
    }

    // MARK: - Functions
    func addNewFood() {
        RealmManager.shared().addNewFood(foodImageURL: foodImageURL, foodName: foodName, categoryName: categoryName, countryName: countryName)
    }

    func deleteFood() {
        RealmManager.shared().deleteFoodWithName(foodName: foodName)
    }

    func getFoods(success: @escaping Success) {
        FoodDetailService.loadFoods(with: foodName) { result in
            switch result {
            case .success(let foods):
                self.foods = foods as? [Food] ?? []
                success(true, "")
            case .failure(let message):
                print(message)
                success(false, message)
            }
        }
    }

    func getSimilarCountryFoods(success: @escaping Success) {
        CountryDetailService.loadFoods(at: country) { result in
            switch result {
            case .success(let foods):
                self.similarCountryFoods = foods as? [Food] ?? []
                success(true, "")
            case .failure(let message):
                print(message)
                success(false, message)
            }
        }
    }

    func getSimilarCategoryFoods(success: @escaping Success) {
        FoodListService.loadFoods(at: category) { result in
            switch result {
            case .success(let foods):
                self.similarCategoryFoods = foods as? [Food] ?? []
                success(true, "")
            case .failure(let message):
                print(message)
                success(false, message)
            }
        }
    }

    func transferFoodName(foodName: String) {
        self.foodName = foodName
    }

    func transferCountryName(countryName: String) {
        country = countryName
    }

    func transferCategoryName(categoryName: String) {
        category = categoryName
    }

    func isFoodAvailable() -> Bool {
        if RealmManager.shared().findFoodByName(foodName: foodName).isEmpty {
            return false
        }
        return true
    }
    
    func numberOfItems(isCountry: Bool) -> Int {
        return isCountry ? similarCountryFoods.count : similarCategoryFoods.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> IngredientsTableCellViewModel {
        let ingredientMass = foods[0].ingredients[indexPath.row]
        let ingredientName = foods[0].measures[indexPath.row]
        
        return IngredientsTableCellViewModel(ingredientMass: ingredientMass, ingredientName: ingredientName)
    }

    func countryViewModelForItem(at indexPath: IndexPath) -> CustomCollectionCellViewModel {
        let foodName = similarCountryFoods[indexPath.row].foodName
        let foodImageURL = similarCountryFoods[indexPath.row].imageURL
        return CustomCollectionCellViewModel(foodName: foodName, imageURL: foodImageURL)
    }

    func categoryViewModelForItem(at indexPath: IndexPath) -> CustomCollectionCellViewModel {
        let foodName = similarCategoryFoods[indexPath.row].foodName
        let foodImageURL = similarCategoryFoods[indexPath.row].imageURL
        return CustomCollectionCellViewModel(foodName: foodName, imageURL: foodImageURL)
    }
}

