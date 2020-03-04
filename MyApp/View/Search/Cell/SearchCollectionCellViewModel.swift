//
//  SearchCollectionCellViewModel.swift
//  MyApp
//
//  Created by PCI0008 on 3/3/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@available(iOS 11.0, *)
protocol SearchCollectionCellViewModelDelegate: class {
    func collectionViewCellModel(collectionViewCellModel: SearchCollectionCellViewModel, needsPerfom action: SearchCollectionCellViewModel.Action)
}

@available(iOS 11.0, *)
final class SearchCollectionCellViewModel {
    
    enum Action {
        case showCookingInstructionVideo(cookingVideoURL: String)
    }
    
    var foodImageURL: String
    var foodName: String
    var cookingVideoURL: String
    weak var delegate: SearchCollectionCellViewModelDelegate?
    
    init(foodImageURL: String = "", foodName: String = "", cookingVideoURL: String = "") {
        self.foodImageURL = foodImageURL
        self.foodName = foodName
        self.cookingVideoURL = cookingVideoURL
    }
    
    func showCookingInstruction() {
        delegate?.collectionViewCellModel(collectionViewCellModel: self, needsPerfom: .showCookingInstructionVideo(cookingVideoURL: cookingVideoURL))
    }
}
