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

    //MARK: - Enum
    enum ViewTypeStatus {
        case tableType
        case collectionType

        var itemSize: CGSize {
            switch self {
            case .tableType:
                return Config.tableTypeItemSize
            case .collectionType:
                return Config.collectionTypeItemSize
            }
        }

        var insetForSection: UIEdgeInsets {
            switch self {
            case .tableType:
                return Config.tableTypeSectionInset
            case .collectionType:
                return Config.collectionTypeSectionInset
            }
        }
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var countryCollectionView: CountryCollectionView!
    @IBOutlet private weak var categoryCollectionView: CategoryCollectionView!

    // MARK: - Private properties
    private let viewModel = HomeViewModel()
    private let categoryCollectionViewCell = "CategoryCollectionViewCell"
    private let countryCollectionViewCell = "CountryCollectionViewCell"
    private let customCollectionViewCell = "CustomCollectionViewCell"
    private var viewTypeStatus = ViewTypeStatus.tableType
    
    // MARK: Override functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        configCustomCollectionView()
    }

    override func setupUI() {
        title = "HOME"
        configNavigationBar()
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
    }

    override func setupData() {
        viewModel.getCategories() { (done, error) in
            if done {
                self.categoryCollectionView.reloadData()
            } else {
                self.alert(title: "API error!", msg: "Getting API not successfully", buttons: ["OK"], preferButton: "OK", handler: nil)
            }
        }
        viewModel.getCountries() { (done, error) in
            if done {
                self.countryCollectionView.reloadData()
            } else {
                self.alert(title: "API error!", msg: "Getting API not successfully", buttons: ["OK"], preferButton: "OK", handler: nil)
            }
        }
    }

    // MARK: - Private functions
    private func configNavigationBar() {
        let viewTypeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "collectionview"), style: .plain, target: self, action: #selector(viewTypeButtonTouchUpInside))
        navigationItem.rightBarButtonItem = viewTypeButton
    }

    private func changeFlowLayout() {
        switch viewTypeStatus {
        case .collectionType:
            viewTypeStatus = .tableType
        case .tableType:
            viewTypeStatus = .collectionType
        }
        categoryCollectionView.reloadData()
    }

    private func setViewTypeButtonIcon() {
        switch viewTypeStatus {
        case .collectionType:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "tableview"), style: .plain, target: self, action: #selector(viewTypeButtonTouchUpInside))
        case .tableType:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "collectionview"), style: .plain, target: self, action: #selector(viewTypeButtonTouchUpInside))
        }
    }

    private func configCustomCollectionView() {
        let customCollectionViewCellNib = UINib(nibName: customCollectionViewCell, bundle: nil)
        categoryCollectionView.register(customCollectionViewCellNib, forCellWithReuseIdentifier: customCollectionViewCell)
    }

    @objc private func viewTypeButtonTouchUpInside() {
        changeFlowLayout()
        setViewTypeButtonIcon()
    }
}

// MARK: - Extensions
@available(iOS 11.0, *)
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(isCountry: collectionView == countryCollectionView, inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCollectionCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
        switch collectionView {
        case countryCollectionView:
            if let countryCollectionCell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CountryCollectionViewCell {
                if UIImage(named: viewModel.countryNames[indexPath.row]) != nil {
                    countryCollectionCell.viewModel = viewModel.viewModelForItem(at: indexPath)
                }
                return countryCollectionCell
            }
        case categoryCollectionView:
            if viewTypeStatus == .collectionType {
                let customCollectionCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell, for: indexPath) as? CustomCollectionViewCell
                customCollectionCell?.viewModel = viewModel.viewModelForItem(at: indexPath)
                customCollectionCell?.nameOfFoodLabel().isHidden = true
                return customCollectionCell ?? CustomCollectionViewCell()
            }
            categoryCollectionCell.viewModel = viewModel.viewModelForItem(at: indexPath)
        default:
            print("Error")
        }

        return categoryCollectionCell
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
            return viewTypeStatus.itemSize
        }
        return Config.countryCollectionViewItemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == countryCollectionView {
            return Config.countryCollectionViewSectionInset
        }
        return viewTypeStatus.insetForSection
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
    static let collectionTypeItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: UIScreen.main.bounds.width * 1 / 2)
    static let collectionTypeSectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    static let tableTypeItemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 130)
    static let tableTypeSectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    static let foodListCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 + 40)
    static let foodListCollectionViewSectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    static let countryDetailCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: UIScreen.main.bounds.width / 2 + 40)
    static let countryDetailCollectionViewSectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    static let favoriteCollectionViewCellHeight = CGFloat(120)
}
