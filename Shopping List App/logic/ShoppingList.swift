//
//  ShoppingList.swift
//  Shopping List App
//
//  Created by bee on 27/10/2022.
//

import Foundation

/// Store the data of a shopping list
class ShoppingList: Sequence {
    private var name: String
    private var items: [ShoppingListItem]
    
    /// init the shopping list
    public init() {
        name = ""
        items = []
    }
    
    /// set property: name
    public func setName(name: String) {
        self.name = name
    }
    
    /// get property: name
    public func getName() -> String {
        return name
    }
    
    /// add an item to list
    public func addItem(name: String, quantity: Int) {
        items.append(ShoppingListItem(name: name, quantity: quantity))
    }
    
    /// get item by row no
    public func getItemByRow(rowNo: Int) -> ShoppingListItem? {
        return items[rowNo]
    }
    
    /// get the iterater for iterating all items in the list
    public func makeIterator() -> IndexingIterator<Array<ShoppingListItem>> {
        return items.makeIterator()
    }
}
