//
//  IngredientsTableViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 3/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet private  weak var ingredientMassLabel: UILabel!
    @IBOutlet private weak var ingredientNameLabel: UILabel!
    
    var viewModel = IngredientsTableCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        ingredientMassLabel.text = viewModel.ingredientMass
        ingredientNameLabel.text = viewModel.ingredientName
    }
}
