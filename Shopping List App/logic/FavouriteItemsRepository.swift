//
//  FavouriteItemsRepository.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 30/10/2022
//  Changes: create the class FavouriteItemsRepository
//

import Foundation

/// Manage the persistence of the favourite items
/// Use user perference to save the favourite items
class FavouriteItemsRepository {
    private static let keyFavouriteItems = "favouriteItems"
    private static let defaultFavouriteItems: [String] = []
    
    /// init the object
    public init() {
        registerUserPerferenceDefault() // first, set the default value of the user perference of the favourite items
    }
    
    /// set the default value of the user perference of the favourite items
    private func registerUserPerferenceDefault() {
        UserDefaults.standard.register(defaults: [
            FavouriteItemsRepository.keyFavouriteItems: FavouriteItemsRepository.defaultFavouriteItems
        ])
    }
    
    /// load saved favourite items from the user perference
    public func load() -> [String] {
        return UserDefaults.standard.array(forKey: FavouriteItemsRepository.keyFavouriteItems)! as! [String]
    }
    
    /// save favourite items to the user perference
    public func save(favouriteItems: [String]) {
        UserDefaults.standard.set(favouriteItems, forKey: FavouriteItemsRepository.keyFavouriteItems)
    }
}
