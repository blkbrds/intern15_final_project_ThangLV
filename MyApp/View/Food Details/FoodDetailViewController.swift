//
//  FoodDetailViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/21/18.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift
import AVKit
import XCDYouTubeKit

@available(iOS 11.0, *)
final class FoodDetailViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var playCookingVideoButton: UIButton!
    @IBOutlet private weak var ingredientListTableView: UITableView!
    @IBOutlet private weak var instructionTextView: UITextView!
    @IBOutlet private weak var countrySimilarCollectionView: UICollectionView!
    @IBOutlet private weak var showMoreCountryFoodsButton: UIButton!
    @IBOutlet private weak var categorySimilarCollectionView: UICollectionView!
    @IBOutlet private weak var showMoreCategoryFoodsButton: UIButton!
    @IBOutlet private weak var tableHeight: NSLayoutConstraint!
    @IBOutlet private weak var similarCountryFoodsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var similarCategoryFoodsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var detailFoodView: UIView!
    @IBOutlet private weak var contentViewHeight: NSLayoutConstraint!

    // MARK: - Properties
    private let ingredientsTableViewCell: String = "IngredientsTableViewCell"
    private let customCollectionViewCell: String = "CustomCollectionViewCell"
    var viewModel = FoodDetailViewModel()
    private var ingredients: [String] = []
    private var similarCountryFoods: [Food] = []
    private var similarCategoryFoods: [Food] = []
    private let numberOfRowsForVisibleFoods: CGFloat = 4
    private let numberOfVisibleFoods: Int = 8

    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        configTableView()
        configNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTheFoodAvailable()
    }

    override func setupUI() {
        super.setupUI()
        title = "FOOD DETAIL"
        foodImageView.layer.masksToBounds = false
        foodImageView.layer.cornerRadius = 25
        foodImageView.clipsToBounds = true
        infoView.layer.masksToBounds = false
        infoView.layer.cornerRadius = 25
        infoView.clipsToBounds = true

        foodNameLabel.numberOfLines = 2
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodNameLabel.lineBreakMode = .byWordWrapping
        NSLayoutConstraint.activate([
            foodNameLabel.topAnchor.constraint(equalTo: infoView.layoutMarginsGuide.topAnchor),
            foodNameLabel.trailingAnchor.constraint(equalTo: infoView.layoutMarginsGuide.trailingAnchor),
            foodNameLabel.leadingAnchor.constraint(equalTo: infoView.layoutMarginsGuide.leadingAnchor)
            ])
        
        showMoreCountryFoodsButton.layer.masksToBounds = false
        showMoreCountryFoodsButton.layer.cornerRadius = 5
        showMoreCountryFoodsButton.clipsToBounds = true
        
        showMoreCategoryFoodsButton.layer.masksToBounds = false
        showMoreCategoryFoodsButton.layer.cornerRadius = 5
        showMoreCategoryFoodsButton.clipsToBounds = true
    }

    override func setupData() {
        super.setupData()
        viewModel.getFoods { (done, msg) in
            if done {
                self.ingredients = self.viewModel.foods[0].ingredients
                self.updateUI()
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
        foodImageView.sd_setImage(with: URL(string: viewModel.foodImageURL), placeholderImage: UIImage(named: "placeholder.png"))
        viewModel.country = countryNameLabel.text ?? ""
        viewModel.category = categoryNameLabel.text ?? ""
        self.ingredientListTableView.reloadData()
        var count = 0
        for i in 0..<ingredients.count {
            if ingredients[i] != "" {
                count += 1
            }
        }
        tableHeight.constant = CGFloat(count - 3) * Config.ingredientTableViewRowHeight
        viewModel.getSimilarCategoryFoods { (done, msg) in
            if done {
                self.similarCategoryFoods = self.viewModel.similarCategoryFoods
                self.categorySimilarCollectionView.reloadData()
                self.configCategorySimilarCollectionView()
            } else {
                print(msg)
            }
        }
        viewModel.getSimilarCountryFoods { (done, msg) in
            if done {
                self.similarCountryFoods = self.viewModel.similarCountryFoods
                self.countrySimilarCollectionView.reloadData()
                self.configCountrySimilarCollectionView()
                self.configScrollView()
            } else {
                print(msg)
            }
        }
        configTextView()
    }

    private func configTableView() {
        let cellNib = UINib(nibName: ingredientsTableViewCell, bundle: nil)
        ingredientListTableView.register(cellNib, forCellReuseIdentifier: ingredientsTableViewCell)
        ingredientListTableView.dataSource = self
        ingredientListTableView.delegate = self
    }

    private func configTextView() {
        let fixedWidth = instructionTextView.frame.size.width
        instructionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = instructionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = instructionTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        instructionTextView.frame = newFrame
        instructionTextView.isEditable = false
    }

    private func configCountrySimilarCollectionView() {
        let cellNib = UINib(nibName: customCollectionViewCell, bundle: nil)
        countrySimilarCollectionView.register(cellNib, forCellWithReuseIdentifier: customCollectionViewCell)
        countrySimilarCollectionView.delegate = self
        countrySimilarCollectionView.dataSource = self
        let numberOfSimilarCountryFoods = similarCountryFoods.count
        switch numberOfSimilarCountryFoods > numberOfVisibleFoods {
        case true:
            similarCountryFoodsCollectionViewHeight.constant = numberOfRowsForVisibleFoods * CGFloat(UIScreen.main.bounds.width / 2) - CGFloat(UIScreen.main.bounds.width / 2)
        case false:
            if numberOfSimilarCountryFoods % 2 == 0 {
                similarCountryFoodsCollectionViewHeight.constant = CGFloat(numberOfSimilarCountryFoods / 2) * CGFloat(UIScreen.main.bounds.width / 2) - CGFloat(UIScreen.main.bounds.width / 2 - 30)
            } else {
                similarCountryFoodsCollectionViewHeight.constant = CGFloat(numberOfSimilarCountryFoods / 2 + 1) * (UIScreen.main.bounds.width / 2) - CGFloat(UIScreen.main.bounds.width / 2 - 30)
            }
        }
    }

    private func configCategorySimilarCollectionView() {
        let cellNib = UINib(nibName: customCollectionViewCell, bundle: nil)
        categorySimilarCollectionView.register(cellNib, forCellWithReuseIdentifier: customCollectionViewCell)
        categorySimilarCollectionView.delegate = self
        categorySimilarCollectionView.dataSource = self
        let numberOfSimilarCategoryFoods = similarCategoryFoods.count
        switch numberOfSimilarCategoryFoods > numberOfVisibleFoods {
        case true:
            similarCategoryFoodsCollectionViewHeight.constant = numberOfRowsForVisibleFoods * CGFloat(UIScreen.main.bounds.width / 2) - CGFloat(UIScreen.main.bounds.width / 2)
        case false:
            if numberOfSimilarCategoryFoods % 2 == 0 {
                similarCategoryFoodsCollectionViewHeight.constant = CGFloat(numberOfSimilarCategoryFoods / 2) * CGFloat(UIScreen.main.bounds.width / 2) - CGFloat(UIScreen.main.bounds.width / 2 - 30)
            } else {
                similarCategoryFoodsCollectionViewHeight.constant = CGFloat(numberOfSimilarCategoryFoods / 2 + 1) * (UIScreen.main.bounds.width / 2) - CGFloat(UIScreen.main.bounds.width / 2 - 30)
            }
        }
    }

    private func configScrollView() {
        contentViewHeight.constant = detailFoodView.frame.height + tableHeight.constant + instructionTextView.frame.height + similarCountryFoodsCollectionViewHeight.constant + similarCategoryFoodsCollectionViewHeight.constant + Config.heightOfOtherViews
        scrollView.isScrollEnabled = true
    }

    private func configNavigationBar() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(rightBarButtonTouchUpInside))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func checkTheFoodAvailable() {
        if viewModel.isFoodAvailable() {
            if let image = UIImage(named: "heart1") {
                navigationItem.rightBarButtonItem?.image = image
            }
        } else {
            if let image = UIImage(named: "heart") {
                navigationItem.rightBarButtonItem?.image = image
            }
        }
    }

    @objc private func rightBarButtonTouchUpInside() {
        switch viewModel.isFoodAvailable() {
        case true:
            viewModel.deleteFood()
            if let image = UIImage(named: "heart") {
                navigationItem.rightBarButtonItem?.image = image
            }
        case false:
            if let image = UIImage(named: "heart1") {
                navigationItem.rightBarButtonItem?.image = image
            }
            viewModel.addNewFood()
            self.alert(title: "", msg: "Add \(viewModel.foodName) successfully to your Favorite List ", buttons: ["OK"], preferButton: "OK", handler: nil)
        }
    }

    // MARK: - IBActions
    @IBAction private func playCookingVideoButtonTouchUpInside(_ sender: Any) {
        var url: String = viewModel.cookingVideoURL
        if let range = viewModel.cookingVideoURL.range(of: "v=") {
            url = String(viewModel.cookingVideoURL[range.upperBound...])
        }

        let playerViewController = AVPlayerViewController()
        self.present(playerViewController, animated: true, completion: nil)

        XCDYouTubeClient.default().getVideoWithIdentifier(url) { (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURL = video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                playerViewController.player = AVPlayer(url: streamURL)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction private func showMoreSimilarCountryFoodsButtonTouchUpInside(_ sender: Any) {
        let countryDetailViewController = CountryDetailViewController()
        countryDetailViewController.transferCountryName(countryName: viewModel.countryName)
        navigationController?.pushViewController(countryDetailViewController, animated: true)
    }

    @IBAction private func showMoreSimilarCategoryFoodsButtonTouchUpInside(_ sender: Any) {
        let foodListViewController = FoodListViewController()
        foodListViewController.transferCategoryName(foodCategory: viewModel.categoryName)
        navigationController?.pushViewController(foodListViewController, animated: true)
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
        guard let cell = ingredientListTableView.dequeueReusableCell(withIdentifier: ingredientsTableViewCell, for: indexPath) as? IngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}

@available(iOS 11.0, *)
extension FoodDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.ingredientTableViewRowHeight
    }
}

@available(iOS 11.0, *)
extension FoodDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(isCountry: collectionView == countrySimilarCollectionView)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case countrySimilarCollectionView:
            guard let countrySimilarCollectionViewCell = countrySimilarCollectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell, for: indexPath) as? CustomCollectionViewCell else {
                return UICollectionViewCell()
            }
            countrySimilarCollectionViewCell.viewModel = viewModel.countryViewModelForItem(at: indexPath)
            return countrySimilarCollectionViewCell
        case categorySimilarCollectionView:
            guard let categorySimilarCollectionViewCell = categorySimilarCollectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell, for: indexPath) as? CustomCollectionViewCell else {
                return UICollectionViewCell()
            }
            categorySimilarCollectionViewCell.viewModel = viewModel.categoryViewModelForItem(at: indexPath)
            return categorySimilarCollectionViewCell
        default:
            print("Error")
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        switch collectionView {
        case countrySimilarCollectionView:
            foodDetailViewController.viewModel.transferFoodName(foodName: viewModel.similarCountryFoods[indexPath.row].foodName)
            navigationController?.pushViewController(foodDetailViewController, animated: true)
        case categorySimilarCollectionView:
            foodDetailViewController.viewModel.transferFoodName(foodName: viewModel.similarCategoryFoods[indexPath.row].foodName)
            navigationController?.pushViewController(foodDetailViewController, animated: true)
        default:
            print("Error.")
        }
    }
}

@available(iOS 11.0, *)
extension FoodDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.foodDetailCollectionViewItemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.foodDetailCollectionViewSectionInset
    }
}



