//
//  CountryDetailViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/20/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class CountryDetailViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let countryCollectionViewCell = "CustomCollectionViewCell"
    private let viewModel = CountryDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func setupUI() {
        configCollectionView()
    }
    
    override func setupData() {
        viewModel.loadAPI { (done, error) in
            if done {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configCollectionView() {
        let countryCollectionCellNib = UINib(nibName: countryCollectionViewCell, bundle: nil)
        collectionView.register(countryCollectionCellNib, forCellWithReuseIdentifier: countryCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getCountryName(countryName: String) {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CustomCollectionViewCell
        let item = viewModel.foods[indexPath.row]
        cell?.configData(foodName: item.foodName)
        viewModel.loadImage(at: indexPath) { [weak self] (done, error) in
            if done {
                cell?.configData(foodName: item.foodName,foodImage: item.foodImage ?? UIImage())
            }
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        navigationController?.pushViewController(foodDetailViewController, animated: true)
    }
}

@available(iOS 11.0, *)
extension CountryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.collectionTypeItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.insetForSection
    }
}
