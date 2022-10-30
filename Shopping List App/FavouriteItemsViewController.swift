//
//  FavouriteItemsViewController.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 30/10/2022
//  Changes: Implement the logic for the UI controls
//

import UIKit

/// View controller for favourite items
class FavouriteItemsViewController: UIViewController {
    private var favouriteItems: [String] = []
    private var favouriteItemsRepository = FavouriteItemsRepository()
    
    @IBOutlet weak var labelFavouriteItems: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favouriteItems = favouriteItemsRepository.load()
        showFavouriteItems() // show favourite items on the UI
    }

    /// show favourite items on the UI
    private func showFavouriteItems() {
        var itemStr = ""
        for item in favouriteItems {
            itemStr.append(item)
            itemStr.append("\n")
        }
        labelFavouriteItems.text = itemStr
    }
}
