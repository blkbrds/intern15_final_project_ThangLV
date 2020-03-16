//
//  SearchViewController.swift
//  MyApp
//
//  Created by PCI0008 on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

@available(iOS 11.0, *)
final class SearchViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    var viewModel = SearchViewModel()
    private let searchCollectionViewCell: String = "SearchCollectionViewCell"
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchBar()
        configCollectionView()
    }
    
    // MARK: - Private functions
    private func configSearchBar() {
        title = "SEARCH"
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search food..."
        searchController.searchBar.setValue("Cancel", forKey:"cancelButtonText")
        searchController.searchBar.tintColor = .red
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func configCollectionView() {
        let searchCollectionViewCellNib = UINib(nibName: searchCollectionViewCell, bundle: nil)
        collectionView.register(searchCollectionViewCellNib, forCellWithReuseIdentifier: searchCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Extensions
@available(iOS 11.0, *)
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCell, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}

@available(iOS 11.0, *)
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Config.collectionTypeItemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Config.collectionTypeSectionInset
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        navigationController?.pushViewController(foodDetailViewController, animated: true)
        foodDetailViewController.viewModel.transferFoodName(foodName: viewModel.foodName(at: indexPath))
    }
}

@available(iOS 11.0, *)
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else { return }
        viewModel.keyword = searchController.searchBar.text ?? ""
        viewModel.getFoods { (done, error) in
            if done {
                self.collectionView.reloadData()
            } else {
                print("Error.")
            }
        }
    }
}



