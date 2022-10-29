//
//  ShoppingListItem.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 27/10/2022
//  Changes: create the class ShoppingListItem
//

import Foundation

/// store the data of an item in shopping list
class ShoppingListItem {
    private var name: String
    private var quantity: Int
    
    /// init the object
    public init() {
        name = ""
        quantity = 0
    }
    
    /// init the object
    public init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
    
    /// set property: name
    public func setName(name: String) {
        self.name = name
    }
    
    /// get property: name
    public func getName() -> String {
        return name
    }
    
    /// set property: quantity
    public func setQuantity(quantity: Int) {
        self.quantity = quantity
    }
    
    /// get property: quantity
    public func getQuantity() -> Int {
        return quantity
    }
}
