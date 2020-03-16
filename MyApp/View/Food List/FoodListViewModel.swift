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
    func getFoods(at indexPath: IndexPath? = nil,success: @escaping Success) {
        FoodListService.loadFoods(at: foodCategory) { [weak self] (result) in
            guard let this = self else {
                success(false, "")
                return
            }
            switch result {
            case .success(let foods):
                if let foods = foods as? [Food] {
                    this.foods = foods
                    success(true, foods[indexPath?.row ?? 0].imageUrl)
                } else {
                    success(false, "Data error.")
                }
            case .failure(let message):
                success(false, message)
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
