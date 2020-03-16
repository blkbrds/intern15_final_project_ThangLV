//
//  CountryDetailViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/21/18.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class CountryDetailViewController: ViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let countryCollectionViewCell = "CustomCollectionViewCell"
    private let viewModel = CountryDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func setupUI() {
        super.setupUI()
        configCollectionView()
    }
    
    override func setupData() {
        viewModel.getFoods() { [weak self] (done, error) in
            if done {
                self?.collectionView.reloadData()
            } else {
                self?.alert(title: error, msg: "Getting API does not successful", buttons: ["OK"], preferButton: "OK", handler: nil)
            }
        }
    }
    
    private func configCollectionView() {
        let countryCollectionCellNib = UINib(nibName: countryCollectionViewCell, bundle: nil)
        collectionView.register(countryCollectionCellNib, forCellWithReuseIdentifier: countryCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func transferCountryName(countryName: String) {
        viewModel.countryName = countryName
        title = "\(countryName.uppercased()) FOODS"
    }
}

@available(iOS 11.0, *)
extension CountryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        foodDetailViewController.viewModel = viewModel.getFoodDetailViewModel(at: indexPath)
        navigationController?.pushViewController(foodDetailViewController, animated: true)
        foodDetailViewController.viewModel.transferCountryName(countryName: viewModel.countryName)
    }
}

@available(iOS 11.0, *)
extension CountryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.countryDetailCollectionViewItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.countryDetailCollectionViewSectionInset
    }
}


