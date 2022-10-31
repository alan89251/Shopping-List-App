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
    private let rowNo: Int
    private let textName: UITextField
    private let labelQuantity: UILabel
    private let stepperQuantity: UIStepper
    private let doSwipeLeftGesture: (UIShoppingListItem)->Void
    private let doSwipeRightGesture: (UIShoppingListItem)->Void
    
    /// init the object
    /// doSwipeLeftGesture: callback that accept the UIShoppingListItem that getting the swipe left gesture
    /// doSwipeRightGesture: callback that accept the UIShoppingListItem that getting the swipe right gesture
    public init(rowNo: Int, textName: UITextField, labelQuantity: UILabel, stepperQuantity: UIStepper,
                doSwipeLeftGesture: @escaping (UIShoppingListItem)->Void, doSwipeRightGesture: @escaping (UIShoppingListItem)->Void) {
        self.rowNo = rowNo
        self.textName = textName
        self.labelQuantity = labelQuantity
        self.stepperQuantity = stepperQuantity
        self.doSwipeLeftGesture = doSwipeLeftGesture
        self.doSwipeRightGesture = doSwipeRightGesture
        
        // config UI properties
        self.stepperQuantity.minimumValue = 0
        // set gesture recognizer for the text field to detect swipe left gesture
        var swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeftGesture))
        swipeLeftGestureRecognizer.direction = .left
        self.textName.addGestureRecognizer(swipeLeftGestureRecognizer)
        // set gesture recognizer for the text field to detect swipe right gesture
        var swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRightGesture))
        swipeRightGestureRecognizer.direction = .right
        self.textName.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    
    /// get the row no
    public func getRowNo() -> Int {
        return rowNo
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
    
    /// handle the swipe left gesture on the TextField of the item name
    @objc private func onSwipeLeftGesture(sender: UISwipeGestureRecognizer) {
        // change the text field color and then restore it to show that the field is being swiped
        let oriColor = textName.backgroundColor
        UIView.animate(withDuration: 1, animations: { ()-> Void in
            self.textName.backgroundColor = UIColor(red: CGFloat(93/255.0), green: CGFloat(64/255.0), blue: CGFloat(55/255.0), alpha: 1.0)
        })
        UIView.animate(withDuration: 1, animations: { ()-> Void in
            self.textName.backgroundColor = oriColor
        })
        
        // run the action trigger by this gesture
        doSwipeLeftGesture(self)
    }
    
    /// handle the swipe right gesture on the TextField of the item name
    @objc private func onSwipeRightGesture(sender: UISwipeGestureRecognizer) {
        // change the text field color and then restore it to show that the field is being swiped
        let oriColor = textName.backgroundColor
        UIView.animate(withDuration: 1, animations: { ()-> Void in
            self.textName.backgroundColor = UIColor(red: 1.0, green: CGFloat(152/255.0), blue: 0.0 , alpha: 1.0)
        })
        UIView.animate(withDuration: 1, animations: { ()-> Void in
            self.textName.backgroundColor = oriColor
        })
        
        // run the action trigger by this gesture
        doSwipeRightGesture(self)
    }
}
