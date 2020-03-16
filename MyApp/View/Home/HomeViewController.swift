//
//  HomeViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
final class HomeViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var countryCollectionView: CountryCollectionView!
    @IBOutlet private weak var categoryCollectionView: CategoryCollectionView!

    // MARK: - Private properties
    private let viewModel = HomeViewModel()
    private let countryCollectionViewCell = "CountryCollectionViewCell"
    private let customCollectionViewCell = "CustomCollectionViewCell"

    // MARK: - Override functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        configCustomCollectionView()
    }

    override func setupUI() {
        super.setupUI()
        title = "HOME"
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
    }

    override func setupData() {
        viewModel.getCategories() { [weak self] (done, message) in
            if done {
                self?.categoryCollectionView.reloadData()
            } else {
                self?.alert(title: message, msg: "Getting API not successfully", buttons: ["OK"], preferButton: "OK", handler: nil)
            }
        }
        viewModel.getCountries() { [weak self] (done, error) in
            if done {
                self?.countryCollectionView.reloadData()
            } else {
                self?.alert(title: error, msg: "Getting API not successfully", buttons: ["OK"], preferButton: "OK", handler: nil)
            }
        }
    }

    // MARK: - Private functions
    private func configCustomCollectionView() {
        let customCollectionViewCellNib = UINib(nibName: customCollectionViewCell, bundle: nil)
        categoryCollectionView.register(customCollectionViewCellNib, forCellWithReuseIdentifier: customCollectionViewCell)
    }
}

// MARK: - Extensions
@available(iOS 11.0, *)
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(isCountry: collectionView == countryCollectionView, inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case countryCollectionView:
            if let countryCollectionCell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CountryCollectionViewCell {
                countryCollectionCell.viewModel = viewModel.viewModelForItem(at: indexPath)
                return countryCollectionCell
            }
        case categoryCollectionView:
                let customCollectionCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell, for: indexPath) as? CustomCollectionViewCell
                customCollectionCell?.viewModel = viewModel.viewModelForItem(at: indexPath)
                return customCollectionCell ?? CustomCollectionViewCell()
        default:
            print("Error")
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case countryCollectionView:
            let countryDetailViewController = CountryDetailViewController()
            navigationController?.pushViewController(countryDetailViewController, animated: true)
            countryDetailViewController.transferCountryName(countryName: viewModel.countryName(at: indexPath))
            UIView.animate(withDuration: 0.3,
                animations: {
                    self.countryCollectionView.transform = CGAffineTransform(scaleX: 0.6, y: 0.4)
                },
                completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.countryCollectionView.transform = CGAffineTransform.identity
                    }
                })
        case categoryCollectionView:
            let foodListViewController = FoodListViewController()
            navigationController?.pushViewController(foodListViewController, animated: true)
            foodListViewController.transferCategoryName(foodCategory: viewModel.categoryName(at: indexPath))
            UIView.animate(withDuration: 0.3,
                animations: {
                    self.categoryCollectionView.transform = CGAffineTransform(scaleX: 0.5, y: 0.8)
                },
                completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.categoryCollectionView.transform = CGAffineTransform.identity
                    }
                })
        default:
            print("Error.")
        }
    }
}

@available(iOS 11.0, *)
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return Config.collectionTypeItemSize
        }
        return Config.countryCollectionViewItemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == countryCollectionView {
            return Config.countryCollectionViewSectionInset
        }
        return Config.collectionTypeSectionInset
    }
}

@available(iOS 11.0, *)
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case countryCollectionView:
            cell.alpha = 0
            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.25) {
                cell.alpha = 1
                cell.transform = .identity
            }
        case categoryCollectionView:
            cell.alpha = 0
            UIView.animate(withDuration: 0.8) {
                cell.alpha = 1
            }

        default:
            print("Animation does not work!")
        }
    }
}

struct Config {
    static let countryCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.height / 10, height: UIScreen.main.bounds.height / 10)
    static let countryCollectionViewSectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    static let collectionTypeItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: UIScreen.main.bounds.width / 2 - 10)
    static let collectionTypeSectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    static let foodListCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 - 20)
    static let foodListCollectionViewSectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    static let countryDetailCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: UIScreen.main.bounds.width / 2 - 10)
    static let countryDetailCollectionViewSectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    static let favoriteCollectionViewCellHeight = CGFloat(140)
    static let ingredientTableViewRowHeight = CGFloat(40)
    static let foodDetailCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.width / 3 + 50, height: UIScreen.main.bounds.width / 3 + 50)
    static let foodDetailCollectionViewSectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static let heightOfOtherViews = CGFloat(550)
}
