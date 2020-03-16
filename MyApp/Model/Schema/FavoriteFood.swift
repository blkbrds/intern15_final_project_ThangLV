//
//  FavoriteFood.swift
//  MyApp
//
//  Created by PCI0008 on 3/4/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

final class FavoriteFood: Object {
    @objc dynamic var foodImageURL: String = ""
    @objc dynamic var foodImage: String = ""
    @objc dynamic var foodName: String = ""
    @objc dynamic var categoryName: String = ""
    @objc dynamic var countryName: String = ""
    @objc dynamic var isFavorite: Bool = false
}
