//
//  HomeViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HomeViewController: ViewController {
    
    // MARK: - Struct
    struct Config {
        static let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var countryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var viewModel = HomeViewModel()

    private let countryCollectionViewCell = "CountryCollectionViewCell"
    private let categoryCollectionViewCell = "CategoryCollectionViewCell"

    // MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HOME"
    }

    override func setupUI() {
        configCategoryCollectionView()
    }
    
    func configCategoryCollectionView() {
        let countryCollectionViewCellNib = UINib(nibName: "CountryCollectionViewCell", bundle: nil)
        countryCollectionView.register(countryCollectionViewCellNib, forCellWithReuseIdentifier: countryCollectionViewCell)
        let categoryCollectionViewCellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(categoryCollectionViewCellNib, forCellWithReuseIdentifier: categoryCollectionViewCell)
        if let flowLayout = countryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
}

// MARK: - Extensions
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == countryCollectionView {
            if let countryCollectionCell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CountryCollectionViewCell {
                countryCollectionCell.configData(image: viewModel.countries[indexPath.row].image)
                return countryCollectionCell
            }
        }
        let categoryCollectionCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewCell, for: indexPath)
        return categoryCollectionCell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: categoryCollectionView.bounds.width - 20, height: 250)
        }
        return CGSize(width: countryCollectionView.bounds.height - 20, height: countryCollectionView.bounds.height - 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.insetForSection
    }
}
