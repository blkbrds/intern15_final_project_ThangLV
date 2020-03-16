//
//  FoodListViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 2/21/18.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class FoodListViewModel {
    var foods: [Food] = []
    var foodCategory: String = ""
    
    func getFoods(at indexPath: IndexPath? = nil,success: @escaping Success) {
        FoodListService.loadFoods(at: foodCategory) { [weak self] result in
            guard let this = self else {
                success(false, "")
                return
            }
            switch result {
            case .success(let foods):
                if let foods = foods as? [Food] {
                    this.foods = foods
                    success(true, foods[indexPath?.row ?? 0].imageURL)
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
