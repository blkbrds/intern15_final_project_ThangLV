//
//  CountryCollectionView.swift
//  MyApp
//
//  Created by PCI0008 on 2/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CountryCollectionView: UICollectionView {
    
    private let countryCollectionViewCell = "CountryCollectionViewCell"
    
    override func awakeFromNib() {
        configCountryCollectionView()
    }
    
    private func configCountryCollectionView() {
        let countryCollectionViewCellNib = UINib(nibName: countryCollectionViewCell, bundle: nil)
        register(countryCollectionViewCellNib, forCellWithReuseIdentifier: countryCollectionViewCell)
        self.delegate = self
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
}

extension CountryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.countryCollectionViewItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.countryCollectionViewSectionInset
    }
}
