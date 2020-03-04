//
//  SearchViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 3/3/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
final class SearchViewModel {
    
    var foods: [Food] = []
    var keyword = ""

    func getFoods(success: @escaping Success) {
        SearchService.loadFoods(with: keyword) { (result) in
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
    
    func numberOfSections() -> Int {
        return foods.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> SearchCollectionCellViewModel {
        let foodImageURL = foods[indexPath.row].imageURL
        let foodName = foods[indexPath.row].foodName
        let cookingVideoURL = foods[indexPath.row].cookingVideoURL
        return SearchCollectionCellViewModel(foodImageURL: foodImageURL, foodName: foodName, cookingVideoURL: cookingVideoURL)
    }
    
    func foodName(at indexPath: IndexPath) -> String {
        return foods[indexPath.row].foodName
    }
}

