//
//  CountryDetailViewModel.swift
//  MyApp
//
//  Created by Chinh Le on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

typealias Success = (Bool, String) -> Void

@available(iOS 11.0, *)
final class CountryDetailViewModel {
    var foods: [Food] = []
    var countryName: String = ""

    func getFoods(success: @escaping Success) {
        CountryDetailService.loadFoods(at: countryName) { (result) in
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
}
