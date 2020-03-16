//
//  FoodListViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/21/18.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
final class FoodListViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let foodListCollectionViewCell = "FoodListCollectionViewCell"
    private let viewModel = FoodListViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Override functions
    override func setupUI() {
        super.setupUI()
        configCollectionView()
    }
    
    override func setupData() {
        viewModel.getFoods() { [weak self] (done, error) in
            if done {
                self?.collectionView.reloadData()
            } else {
                self?.alert(title: error, msg: error, buttons: ["OK"], preferButton: "OK", handler: nil)
            }
        }
    }
    
    private func configCollectionView() {
        let foodListCellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(foodListCellNib, forCellWithReuseIdentifier: foodListCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func transferCategoryName(foodCategory: String) {
        viewModel.foodCategory = foodCategory
        title = foodCategory.uppercased()
    }
}

// MARK: - Extensions
@available(iOS 11.0, *)
extension FoodListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodListCollectionViewCell, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        foodDetailViewController.viewModel = viewModel.getFoodDetailViewModel(at: indexPath)
        navigationController?.pushViewController(foodDetailViewController, animated: true)
        foodDetailViewController.viewModel.transferCategoryName(categoryName: viewModel.foodCategory)
    }
}

@available(iOS 11.0, *)
extension FoodListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.foodListCollectionViewItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.foodListCollectionViewSectionInset
    }
}
