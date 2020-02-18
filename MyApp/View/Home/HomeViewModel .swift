//
//  HomeViewModel .swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

typealias Completion = (Bool, String) -> Void

final class HomeViewModel {
    let countryNames: [String] = ["American", "British", "Canadian", "Chinese", "Dutch", "Egyptian", "French",
                                  "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan",
                                  "Malaysian", "Mexican", "Moroccan", "Russian", "Spanish", "Thai", "Tunisian",
                                  "Turkish", "Vietnamese"]
    var countries: [Country] = []
    
    init() {
        countries = countryNames.map({ Country(name: $0, image: UIImage(named: $0))})
    }
    
    
}
