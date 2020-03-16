//
//  CountryCollectionCellViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 2/26/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class CountryCollectionCellViewModel {
    
    var countryImageURL: String
    var countryName: String
    var countryImage: UIImage? = nil

    init(countryImageUrl: String = "", countryName: String = "", countryImage: UIImage? = nil) {
        self.countryImageUrl = countryImageUrl
        self.countryName = countryName
        self.countryImage = UIImage(named: countryName)
    }
}
