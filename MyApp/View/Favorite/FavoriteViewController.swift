//
//  FavoriteViewController.swift
//  MyApp
//
//  Created by PCI0008 on 3/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import RealmSwift

@available(iOS 11.0, *)
class FavoriteViewController: ViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let favoriteTableViewCell: String = "FavoriteTableViewCell"
    var viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAVORITE"
        configTableView()
        configNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func configTableView() {
        let favoriteTableViewCellNib = UINib(nibName: favoriteTableViewCell, bundle: nil)
        tableView.register(favoriteTableViewCellNib, forCellReuseIdentifier: favoriteTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configNavigationBar() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(rightBarButtonTouchUpInside))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightBarButtonTouchUpInside() {
        alert1(msg: "Delete all?", tableView: tableView, handler: nil)
    }
}

@available(iOS 11.0, *)
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteTableViewCell, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.viewModel.deleteFood(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodDetailViewController = FoodDetailViewController()
        foodDetailViewController.viewModel.transferFoodName(foodName: viewModel.favoriteFoods[indexPath.row].foodName)
        navigationController?.pushViewController(foodDetailViewController, animated: true)
    }
}

@available(iOS 11.0, *)
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.favoriteCollectionViewCellHeight
    }
}
