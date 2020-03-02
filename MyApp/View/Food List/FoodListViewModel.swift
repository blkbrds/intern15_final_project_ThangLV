//
//  FoodListViewModel.swift
//  MyApp
//
//  Created by Chinh Le on 2/22/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class FoodListViewModel {
    // MARK: - Properties
    var foods: [Food] = []
    var foodCategory: String = ""
    
    // MARK: - Functions
    func getFoods(success: @escaping Success) {
        FoodListService.loadFoods(at: foodCategory) { (result) in
            switch result {
            case .success(let foods):
                if let foods = foods as? [Food] {
                    self.foods = foods
                    success(true, "")
                }
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return foods.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> CustomCollectionCellViewModel {
        let foodName = foods[indexPath.row].foodName
        let imageURL = foods[indexPath.row].imageURL
        return CustomCollectionCellViewModel(foodName: foodName, imageURL: imageURL)
    }
    
    func getFoodDetailViewModel(at indexPath: IndexPath) -> FoodDetailViewModel {
        return FoodDetailViewModel(foodName: foods[indexPath.row].foodName)
    }
}
