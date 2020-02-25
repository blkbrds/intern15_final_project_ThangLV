//
//  Country.swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

final class Country {
    var name: String = ""
    var ensignImage: UIImage? = nil
    
    init(json: JSONObject = [:], ensignImage: UIImage? = nil) {
        name = json["strArea"] as? String ?? ""
        self.ensignImage = ensignImage
    }
}
