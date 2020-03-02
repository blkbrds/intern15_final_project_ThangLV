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
    
    init(countryImageURL: String = "", countryName: String = "") {
        self.countryImageURL = countryImageURL
        self.countryName = countryName
    }
}
