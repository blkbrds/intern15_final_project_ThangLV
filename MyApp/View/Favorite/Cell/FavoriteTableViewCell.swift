//
//  FavoriteTableViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 3/4/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

protocol FavoriteTableViewCellDelegate: class {
    func tableViewCell(tableViewCell: FavoriteTableViewCell, needsPerform action: FavoriteTableViewCell.Action)
}

class FavoriteTableViewCell: UITableViewCell {
    
    enum Action {
        case deleteFoodWithName(foodName: String)
    }

    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    
    var viewModel = FavoriteTableCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    weak var delegate: FavoriteTableViewCellDelegate?
    
    private func updateView() {
        foodNameLabel.text = viewModel.foodName
        categoryNameLabel.text = viewModel.categoryName
        countryNameLabel.text = viewModel.countryName
        foodImageView.sd_setImage(with: URL(string: viewModel.foodImageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    @IBAction func deleteButtonTouchUpInside(_ sender: Any) {
        delegate?.tableViewCell(tableViewCell: self, needsPerform: .deleteFoodWithName(foodName: foodNameLabel.text ?? ""))
    }
}
