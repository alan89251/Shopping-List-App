//
//  ShoppingListRepository.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 29/10/2022
//  Changes: create the class ShoppingListRepository
//

import Foundation

/// Manage the persistence of the saved shopping list
/// Use user perference to save the shopping list
class ShoppingListRepository {
    private static let keyShoppingListName = "shoppingListName"
    private static let defaultShoppingListName = "Shopping List"
    private static let keyItemNamePrefix = "itemName"
    private static let defaultItemName = ""
    private static let keyItemQuantityPrefix = "itemQuantity"
    private static let defaultQuantity = 0
    
    /// init the object
    public init() {
        registerUserPerferenceDefault() // first, set the default value of the user perference of the shopping list
    }
    
    /// set the default value of the user perference of the shopping list
    private func registerUserPerferenceDefault() {
        UserDefaults.standard.register(defaults: [
            ShoppingListRepository.keyShoppingListName: ShoppingListRepository.defaultShoppingListName,
            ShoppingListRepository.keyItemNamePrefix + "1": ShoppingListRepository.defaultItemName,
            ShoppingListRepository.keyItemQuantityPrefix + "1": ShoppingListRepository.defaultQuantity,
            ShoppingListRepository.keyItemNamePrefix + "2": ShoppingListRepository.defaultItemName,
            ShoppingListRepository.keyItemQuantityPrefix + "2": ShoppingListRepository.defaultQuantity,
            ShoppingListRepository.keyItemNamePrefix + "3": ShoppingListRepository.defaultItemName,
            ShoppingListRepository.keyItemQuantityPrefix + "3": ShoppingListRepository.defaultQuantity,
            ShoppingListRepository.keyItemNamePrefix + "4": ShoppingListRepository.defaultItemName,
            ShoppingListRepository.keyItemQuantityPrefix + "4": ShoppingListRepository.defaultQuantity,
            ShoppingListRepository.keyItemNamePrefix + "5": ShoppingListRepository.defaultItemName,
            ShoppingListRepository.keyItemQuantityPrefix + "5": ShoppingListRepository.defaultQuantity
        ])
    }
    
    /// load saved shopping list from the user perference
    public func load() -> ShoppingList {
        var savedShoppingList = ShoppingList()
        savedShoppingList.setName(name: UserDefaults.standard.string(forKey: ShoppingListRepository.keyShoppingListName)!)
        for i in 1 ... 5 { // load the 5 rows of shopping items
            savedShoppingList.addItem(name: UserDefaults.standard.string(forKey: ShoppingListRepository.keyItemNamePrefix + String(i))!,
                                      quantity: UserDefaults.standard.integer(forKey: ShoppingListRepository.keyItemQuantityPrefix + String(i)))
        }
        return savedShoppingList
    }
    
    /// save shopping list to the user perference
    public func save(shoppingList: ShoppingList) {
        UserDefaults.standard.set(shoppingList.getName(), forKey: ShoppingListRepository.keyShoppingListName)
        var i = 1
        for item in shoppingList {
            UserDefaults.standard.set(item.getName(), forKey: ShoppingListRepository.keyItemNamePrefix + String(i))
            UserDefaults.standard.set(item.getQuantity(), forKey: ShoppingListRepository.keyItemQuantityPrefix + String(i))
            i += 1
        }
    }
}
