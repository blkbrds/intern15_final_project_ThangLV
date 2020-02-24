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
                return CGSize(width: UIScreen.main.bounds.width - 20, height: 250)
            case .collectionType:
                return CGSize(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2)
            }
        }
    }

    // MARK: - Struct
    struct Config {
        static let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var countryCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!

    // MARK: - Private properties
    private let viewModel = HomeViewModel()
    private let countryCollectionViewCell = "CountryCollectionViewCell"
    private let categoryCollectionViewCell = "CategoryCollectionViewCell"
    private var viewTypeStatus = ViewTypeStatus.tableType

    // MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        title = "HOME"
        configCategoryCollectionView()
        configCountryCollectionView()
        configNavigationBar()
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
    private func configCategoryCollectionView() {
        let categoryCollectionViewCellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(categoryCollectionViewCellNib, forCellWithReuseIdentifier: categoryCollectionViewCell)
        if let flowLayout = countryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }

    private func configCountryCollectionView() {
        let countryCollectionViewCellNib = UINib(nibName: "CountryCollectionViewCell", bundle: nil)
        countryCollectionView.register(countryCollectionViewCellNib, forCellWithReuseIdentifier: countryCollectionViewCell)
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
    }

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
        if collectionView == countryCollectionView {
            return viewModel.countries.count
        }
        return viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCollectionCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell

        switch collectionView {
        case countryCollectionView:
            if let countryCollectionCell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CountryCollectionViewCell {
                countryCollectionCell.configData(name: viewModel.countries[indexPath.row].name, image: UIImage(named: viewModel.countryNames[indexPath.row]) ?? UIImage())

                return countryCollectionCell
            }
        case categoryCollectionView:
            categoryCollectionCell.updateData(category: viewModel.categories[indexPath.row])
            Networking.shared().downloadImage(url: viewModel.categories[indexPath.row].categoryThumb) { (image) in
                if let image = image {
                    categoryCollectionCell.updateData2(image: image)
                    self.viewModel.categories[indexPath.row].categoryImage = image
                } else {
                    categoryCollectionCell.updateData2(image: nil)
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
        return CGSize(width: countryCollectionView.bounds.height - 20, height: countryCollectionView.bounds.height - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.insetForSection
    }
}
