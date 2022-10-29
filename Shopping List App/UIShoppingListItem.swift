//
//  UIShoppingListItem.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 27/10/2022
//  Changes: Create the class UIShoppingListItem
//

import Foundation
import UIKit

/// Manage the UIs of an shopping list item
class UIShoppingListItem {
    private let textName: UITextField
    private let labelQuantity: UILabel
    private let stepperQuantity: UIStepper
    
    /// init the object
    public init(textName: UITextField, labelQuantity: UILabel, stepperQuantity: UIStepper) {
        self.textName = textName
        self.labelQuantity = labelQuantity
        self.stepperQuantity = stepperQuantity
    }
    
    /// set the item name
    public func setName(name: String) {
        self.textName.text = name
    }
    
    /// get the item name
    public func getName() -> String {
        if (textName.text != nil) {
            return textName.text!
        }
        else {
            return ""
        }
    }
    
    /// set the item quantity
    public func setQuantity(quantity: Int) {
        labelQuantity.text = String(quantity)
        stepperQuantity.value = Double(quantity)
    }
    
    /// get the item quantity
    public func getQuantity() -> Int {
        if (labelQuantity.text != nil) {
            return Int(labelQuantity.text!)!
        }
        else {
            return 0
        }
    }
    
    /// update the quantity shown in the label by the quantity got from the stepper
    public func updateLabelQuantityFromStepper() {
        labelQuantity.text = String(Int(stepperQuantity.value))
    }
}
