//
//  FoodDetailViewController.swift
//  MyApp
//
//  Created by Chinh Le on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

@available(iOS 11.0, *)
final class FoodDetailViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var ingredientListTableView: UITableView!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var ingredientsButton: UIButton!

    // MARK: - Properties
    private let systemCell = "SystemCell"
    var viewModel = FoodDetailViewModel()
    var ingredients: [String] = []
    var measures: [String] = []
    var isFavorite: Bool = false
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        configTableView()
    }

    override func setupUI() {
        title = "FOOD DETAIL"
        foodImageView.layer.masksToBounds = false
        foodImageView.layer.cornerRadius = 25
        foodImageView.clipsToBounds = true
        infoView.layer.masksToBounds = false
        infoView.layer.cornerRadius = 25
        infoView.clipsToBounds = true
    }

    override func setupData() {
        viewModel.getFoods { (done, msg) in
            if done {
                self.updateUI()
                self.ingredients = self.viewModel.foods[0].ingredients
                self.measures = self.viewModel.foods[0].measures
            } else {
                print(msg)
            }
        }
    }

    // MARK: - Private functions
    private func updateUI() {
        foodNameLabel.text = viewModel.foodName
        categoryNameLabel.text = viewModel.categoryName
        countryNameLabel.text = viewModel.countryName
        instructionTextView.text = viewModel.cookingInstruction
        ingredientListTableView.isHidden = true
        foodImageView.sd_setImage(with: URL(string: viewModel.foodImageURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.ingredientListTableView.reloadData()
    }

    private func configTableView() {
        ingredientListTableView.register(UITableViewCell.self, forCellReuseIdentifier: systemCell)
        ingredientListTableView.dataSource = self
    }

    // MARK: - IBActions
    @IBAction func instructionButtonTouchUpInside(_ sender: Any) {
        instructionTextView.isHidden = false
        ingredientListTableView.isHidden = true
    }

    @IBAction func ingredientsButtonTouchUpInside(_ sender: Any) {
        instructionTextView.isHidden = true
        ingredientListTableView.isHidden = false
    }
    
    @IBAction func favoriteButtonTouchUpInside(_ sender: Any) {
        switch isFavorite {
        case true:
            isFavorite = false
            if let image = UIImage(named: "heart") {
                favoriteButton.setImage(image, for: .normal)
            }
        case false:
            isFavorite = true
            if let image = UIImage(named: "heart1") {
                favoriteButton.setImage(image, for: .normal)
            }
            viewModel.addNewFood()
        }
    }
}

// MARK: - Extensions
@available(iOS 11.0, *)
extension FoodDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = ingredients.count
        for i in 0..<ingredients.count {
            if ingredients[i] == "" {
                count -= 1
            }
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientListTableView.dequeueReusableCell(withIdentifier: systemCell, for: indexPath)
        cell.textLabel?.text = "\(measures[indexPath.row]) \(ingredients[indexPath.row])"
        return cell
    }
}


