//
//  FavoriteViewController.swift
//  MyApp
//
//  Created by Chinh Le on 2/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!

    private let favoriteTableViewCell: String = "FavoriteTableViewCell"
    var viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAVORITE"
        configTableView()
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
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteTableViewCell, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        cell.delegate = self
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.favoriteCollectionViewCellHeight
    }
}

extension FavoriteViewController: FavoriteTableViewCellDelegate {
    func tableViewCell(tableViewCell: FavoriteTableViewCell, needsPerform action: FavoriteTableViewCell.Action) {
        switch action {
        case .deleteFoodWithName(let foodName):
            RealmManager.shared().deleteFoodWithName(foodName: foodName)
            tableView.reloadData()
        }
    }
}

