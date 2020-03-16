//
//  RealmManager.swift
//  MyApp
//
//  Created by PCI0008 on 3/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {

    //MARK: - Singleton
    private static var sharedRealmManager: RealmManager = {
        let sharedRealmManager = RealmManager()
        return sharedRealmManager
    }()

    static func shared() -> RealmManager {
        return sharedRealmManager
    }

    let realm = try! Realm()

    lazy var favoriteFoods: Results<FavoriteFood> = { realm.objects(FavoriteFood.self) }()

    //init
    private init() { }

    func addNewFood(foodImageURL: String, foodName: String, categoryName: String, countryName: String) {
        try! realm.write {
            let favoriteFood = FavoriteFood()
            favoriteFood.foodImageURL = foodImageURL
            favoriteFood.foodName = foodName
            favoriteFood.categoryName = categoryName
            favoriteFood.countryName = countryName
            realm.add(favoriteFood)
        }
    }
    
    func findFoodByName(foodName: String) -> Results<FavoriteFood> {
        let favoriteFood = realm.objects(FavoriteFood.self).filter(NSPredicate(format: "foodName = %@", foodName))
        return favoriteFood
    }
    
    func deleteFoodWithName(foodName: String) {
        let favoriteFood = realm.objects(FavoriteFood.self).filter(NSPredicate(format: "foodName = %@", foodName))
        try? realm.write {
            realm.delete(favoriteFood)
        }
    }
    
    func deleteAllFoods() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
