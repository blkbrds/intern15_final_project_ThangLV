//
//  FoodListViewModel.swift
//  MyApp
//
//  Created by Chinh Le on 2/22/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

@available(iOS 11.0, *)
final class FoodListViewModel: ViewModel {
    var foods: [Food] = []
    var foodCategory: String = ""
    
    func getFoods(at indexPath: IndexPath? = nil,success: @escaping Success) {
        FoodListService.loadFoods(at: foodCategory) { (result) in
            switch result {
            case .success(let foods):
                if let foods = foods as? [Food] {
                    self.foods = foods
                    success(true, foods[indexPath?.row ?? 0].imageUrl)
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
        return CustomCollectionCellViewModel(foodName: foodName)
    }
}
