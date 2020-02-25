//
//  HomeViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

// MARK: - Struct
struct Config {
    static let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static let tableTypeItemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 250)
    static let collectionTypeItemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2)
    static let countryCollectionViewItemSize = CGSize(width: UIScreen.main.bounds.height / 9, height: UIScreen.main.bounds.height / 9)
}

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
}


@available(iOS 11.0, *)
final class HomeViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var countryCollectionView: CountryCollectionView!
    @IBOutlet private weak var categoryCollectionView: CategoryCollectionView!

    // MARK: - Private properties
    private let viewModel = HomeViewModel()
    private let categoryCollectionViewCell = "CategoryCollectionViewCell"
    private let countryCollectionViewCell = "CountryCollectionViewCell"
    private var viewTypeStatus = ViewTypeStatus.tableType

    // MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        viewModel.loadAPI { (done, error) in
            if done {
                self.categoryCollectionView.reloadData()
            }
        }
        viewModel.loadAPI2 { (done, error) in
            if done {
                self.countryCollectionView.reloadData()
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
                countryCollectionCell.configData(name: viewModel.countryName(at: indexPath), image: UIImage(named: viewModel.countryNames[indexPath.row]) ?? UIImage())

                return countryCollectionCell
            }
        case categoryCollectionView:
            categoryCollectionCell.updateData(category: viewModel.categoryName(at: indexPath))
            Networking.shared().downloadImage(url: viewModel.categoryThumb(at: indexPath)) { (image) in
                if let image = image {
                    categoryCollectionCell.updateData(image: image)
                    self.viewModel.categoryThumb(at: indexPath)
                } else {
                    categoryCollectionCell.updateData(image: nil)
                }
            }
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
        case categoryCollectionView:
            let foodListViewController = FoodListViewController()
            navigationController?.pushViewController(foodListViewController, animated: true)
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
}
