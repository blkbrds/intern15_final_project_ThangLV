//
//  SearchCollectionViewCell.swift
//  MyApp
//
//  Created by PCI0008 on 3/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

@available(iOS 11.0, *)
final class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var seeTheInstructionButton: UIButton!
    
    var viewModel = SearchCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateView() {
        foodImageView.sd_setImage(with: URL(string: viewModel.foodImageURL), placeholderImage: UIImage(named: "placeholder.png"))
        foodNameLabel.text = viewModel.foodName
    }
    
    @IBAction func seeTheInstructionButtonTouchUpInside(_ sender: Any) {
        viewModel.showCookingInstruction()
    }
}
