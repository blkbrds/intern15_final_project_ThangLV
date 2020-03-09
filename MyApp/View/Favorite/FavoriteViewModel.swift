//
//  FavoriteViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 3/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class FavoriteViewModel: ViewModel {
    var favoriteFoods = RealmManager.shared().realm.objects(FavoriteFood.self)
    
    func viewModelForItem(at indexPath: IndexPath) -> FavoriteTableCellViewModel {
        let foodImageURL = favoriteFoods[indexPath.row].foodImageURL
        let foodName = favoriteFoods[indexPath.row].foodName
        let categoryName = favoriteFoods[indexPath.row].categoryName
        let countryName = favoriteFoods[indexPath.row].countryName
        
        return FavoriteTableCellViewModel(foodImageURL: foodImageURL, foodName: foodName, categoryName: categoryName, countryName: countryName)
    }
    
    func numberOfSections() -> Int {
        return favoriteFoods.count
    }
}
