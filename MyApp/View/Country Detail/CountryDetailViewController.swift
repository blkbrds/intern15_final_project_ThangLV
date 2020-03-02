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
        viewModel.getFoods() { (done, _) in
            if done {
                self.collectionView.reloadData()
            } else {
                self.alert(title: "API error!", msg: "Getting API not successfully", buttons: ["OK"], preferButton: "OK", handler: nil)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: countryCollectionViewCell, for: indexPath) as? CustomCollectionViewCell
        cell?.viewModel = viewModel.viewModelForItem(at: indexPath)

        viewModel.getFoods(at: indexPath) { (done, url) in
            if done {
                cell?.loadImage().sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
            } else {
                print("Cannot load images")
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
