//
//  CustomCollectionViewCell.swift
//  MyApp
//
//  Created by Chinh Le on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

final class CustomCollectionViewCell: CollectionCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    
    var viewModel = CustomCollectionCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Override functions
    override func awakeFromNib() {
        setupUI()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        foodImageView.layer.cornerRadius = foodImageView.frame.size.width / 2
    }
    
    // MARK: Private functions
    private func updateView() {
        foodNameLabel.text = viewModel.foodName
        foodImageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }

    private func setupUI() {
        layer.masksToBounds = false
        layer.cornerRadius = 20
        clipsToBounds = true
        foodNameLabel.layer.masksToBounds = false
        foodNameLabel.layer.cornerRadius = 2
        foodNameLabel.clipsToBounds = true
        foodNameLabel.backgroundColor = randomColor()
    }
    
    //MARK: - Functions
    func loadImage() -> UIImageView {
        return foodImageView
    }

    func nameOfFoodLabel() -> UILabel {
        return foodNameLabel
    }

    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
