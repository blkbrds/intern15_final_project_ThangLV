//
//  FoodListViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/20/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
final class FoodListViewController: ViewController {
    
    // MARK; IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private functions
    private let foodListCollectionViewCell = "FoodListCollectionViewCell"
    private let viewModel = FoodListViewModel()
    
    // MARK: - Overrride functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func setupUI() {
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
    
    // MARK: - Private functions
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
        
        viewModel.getFoods(at: indexPath) { [weak self] (done, url) in
            if done {
                cell.loadImage().sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
            } else {
                print("Cannot load images")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        foodDetailViewController.viewModel = viewModel.getFoodDetailViewModel(at: indexPath)
        navigationController?.pushViewController(foodDetailViewController, animated: true)
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
