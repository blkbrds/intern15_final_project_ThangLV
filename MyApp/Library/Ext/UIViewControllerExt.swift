//
//  UIKitEx.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String? = nil, msg: String, buttons: [String] = ["OK"], preferButton: String = "", handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            // Bold button title
            if !preferButton.isEmpty && preferButton == button {
                let action = UIAlertAction(title: button, style: .default, handler: { action in
                    handler?(action)
                })
                alert.addAction(action)
                alert.preferredAction = action
            } else {
                let action = UIAlertAction(title: button, style: .default, handler: nil)
                alert.addAction(action)
            }
        }
        present(alert, animated: true, completion: nil)
    }
    
    func alert1(title: String? = nil, msg: String, buttons: [String] = ["OK", "Cancel"], tableView: UITableView, preferButton: String = "", handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            RealmManager.shared().deleteAllFoods()
            tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
        }))
        present(alert, animated: true, completion: nil)
    }
}
