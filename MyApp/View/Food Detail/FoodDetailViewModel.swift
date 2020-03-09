//
//  FoodDetailViewModel.swift
//  MyApp
//
//  Created by Chinh Le on 2/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

@available(iOS 11.0, *)
final class FoodDetailViewModel {
    
    // MARK: - Properties
//    let realm = try! Realm()
//    lazy var favoriteFoods: Results<FavoriteFood> = { self.realm.objects(FavoriteFood.self) }()
    var foods: [Food] = []
    var foodName = ""
    
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
    
    // MARK: - init()
    init() {}
    
    init(foodName: String) {
        self.foodName = foodName
    }
    
    // MARK: - Functions
    func addNewFood() {
        RealmManager.shared().addNewFood(foodImageURL: foodImageURL, foodName: foodName, categoryName: categoryName, countryName: countryName)
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
    
    func transferFoodName(foodName: String) {
        self.foodName = foodName
    }
}
