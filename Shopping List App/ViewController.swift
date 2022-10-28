//
//  ViewController.swift
//  Shopping List App
//
//  Created by alan on 27/10/2022.
//

import UIKit

class ViewController: UIViewController {
    private var savedShoppingList = ShoppingList()
    private var uiShoppinglist: [Int: UIShoppingListItem] = [:] /// KEY: row number
    
    @IBOutlet weak var textShoppingListName: UITextField!
    @IBOutlet weak var textItem1: UITextField!
    @IBOutlet weak var textItem2: UITextField!
    @IBOutlet weak var textItem3: UITextField!
    @IBOutlet weak var textItem4: UITextField!
    @IBOutlet weak var textItem5: UITextField!
    @IBOutlet weak var labelQuantity1: UILabel!
    @IBOutlet weak var labelQuantity2: UILabel!
    @IBOutlet weak var labelQuantity3: UILabel!
    @IBOutlet weak var labelQuantity4: UILabel!
    @IBOutlet weak var labelQuantity5: UILabel!
    @IBOutlet weak var stepperQuantity1: UIStepper!
    @IBOutlet weak var stepperQuantity2: UIStepper!
    @IBOutlet weak var stepperQuantity3: UIStepper!
    @IBOutlet weak var stepperQuantity4: UIStepper!
    @IBOutlet weak var stepperQuantity5: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedShoppingList.setName(name: "Shopping List")
        savedShoppingList.addItem(name: "", quantity: 0)
        savedShoppingList.addItem(name: "", quantity: 0)
        savedShoppingList.addItem(name: "", quantity: 0)
        savedShoppingList.addItem(name: "", quantity: 0)
        savedShoppingList.addItem(name: "", quantity: 0)
        initUiShoppinglist(shoppingList: savedShoppingList)
    }
    
    /// init the value of UIs and save their references to the list
    private func initUiShoppinglist(shoppingList: ShoppingList) {
        initItemRow(rowNo: 0, textName: textItem1, labelQuantity: labelQuantity1, stepperQuantity: stepperQuantity1, shoppingListItem: shoppingList.getItemByRow(rowNo: 0)!)
        initItemRow(rowNo: 1, textName: textItem2, labelQuantity: labelQuantity2, stepperQuantity: stepperQuantity2, shoppingListItem: shoppingList.getItemByRow(rowNo: 1)!)
        initItemRow(rowNo: 2, textName: textItem3, labelQuantity: labelQuantity3, stepperQuantity: stepperQuantity3, shoppingListItem: shoppingList.getItemByRow(rowNo: 2)!)
        initItemRow(rowNo: 3, textName: textItem4, labelQuantity: labelQuantity4, stepperQuantity: stepperQuantity4, shoppingListItem: shoppingList.getItemByRow(rowNo: 3)!)
        initItemRow(rowNo: 4, textName: textItem5, labelQuantity: labelQuantity5, stepperQuantity: stepperQuantity5, shoppingListItem: shoppingList.getItemByRow(rowNo: 4)!)
    }
    
    /// init an item row that set its initial values and save its reference to list
    private func initItemRow(rowNo: Int, textName: UITextField, labelQuantity: UILabel, stepperQuantity: UIStepper, shoppingListItem: ShoppingListItem) {
        stepperQuantity.minimumValue = 0
        var item = UIShoppingListItem(textName: textName, labelQuantity: labelQuantity, stepperQuantity: stepperQuantity)
        uiShoppinglist[rowNo] = item
        setItemRow(rowNo: rowNo, name: shoppingListItem.getName(), quantity: shoppingListItem.getQuantity())
    }
    
    /// set the values of an item row
    private func setItemRow(rowNo: Int, name: String, quantity: Int) {
        var item: UIShoppingListItem! = uiShoppinglist[rowNo]
        item.setName(name: name)
        item.setQuantity(quantity: quantity)
    }
    
    /// change the item quantity according to the stepper value
    @IBAction func stepperQuantity_onChange(_ sender: UIStepper) {
        if (sender == stepperQuantity1) {
            uiShoppinglist[0]!.updateLabelQuantityFromStepper()
        }
        else if (sender == stepperQuantity2) {
            uiShoppinglist[1]!.updateLabelQuantityFromStepper()
        }
        else if (sender == stepperQuantity3) {
            uiShoppinglist[2]!.updateLabelQuantityFromStepper()
        }
        else if (sender == stepperQuantity4) {
            uiShoppinglist[3]!.updateLabelQuantityFromStepper()
        }
        else if (sender == stepperQuantity5) {
            uiShoppinglist[4]!.updateLabelQuantityFromStepper()
        }
    }
    
    /// save the shopping list
    @IBAction func btnSave_onTouchUpInside(_ sender: UIButton) {
        savedShoppingList.setName(name: textShoppingListName.text!)
        for i in 0 ... uiShoppinglist.count-1 {
            var item: ShoppingListItem! = savedShoppingList.getItemByRow(rowNo: i)
            item.setName(name: uiShoppinglist[i]!.getName())
            item.setQuantity(quantity: uiShoppinglist[i]!.getQuantity())
        }
        printShoppingListInDebugConsole(shoppingList: savedShoppingList)
    }
    
    /// print the shopping list to the debug console
    private func printShoppingListInDebugConsole(shoppingList: ShoppingList) {
        print("Shopping list name: " + shoppingList.getName())
        for item in shoppingList {
            print("Item: " + item.getName() + "\t" + "Quantity: " + String(item.getQuantity()))
        }
    }
    
    /// reset the shopping list
    @IBAction func btnCancel_onTouchUpInside(_ sender: UIButton) {
        textShoppingListName.text = savedShoppingList.getName()
        for i in 0 ... 4 {
            let item: ShoppingListItem! = savedShoppingList.getItemByRow(rowNo: i)
            setItemRow(rowNo: i, name: item.getName(), quantity: item.getQuantity())
        }
    }
}

