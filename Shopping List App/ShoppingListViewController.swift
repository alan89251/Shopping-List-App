//
//  ShoppingListViewController.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 27/10/2022
//  Changes: Implement the logic for the UI controls
//

import UIKit

/// ViewController of the shopping list content view
class ShoppingListViewController: UIViewController {
    private var savedShoppingList = ShoppingList()
    private var favouriteItems: [String] = []
    private let shoppingListRepository = ShoppingListRepository()
    private var favouriteItemsRepository = FavouriteItemsRepository()
    private var uiShoppinglist: [Int: UIShoppingListItem] = [:] /// KEY: row number. Store the row of ui controls of list items
    
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
        
        savedShoppingList = shoppingListRepository.load()
        favouriteItems = favouriteItemsRepository.load()
        initUiShoppinglist(shoppingList: savedShoppingList)
    }
    
    /// init the values of UIs and save their references to the "uiShoppinglist"
    private func initUiShoppinglist(shoppingList: ShoppingList) {
        textShoppingListName.text = shoppingList.getName()
        initItemRow(rowNo: 0, textName: textItem1, labelQuantity: labelQuantity1, stepperQuantity: stepperQuantity1, shoppingListItem: shoppingList.getItemByRow(rowNo: 0)!)
        initItemRow(rowNo: 1, textName: textItem2, labelQuantity: labelQuantity2, stepperQuantity: stepperQuantity2, shoppingListItem: shoppingList.getItemByRow(rowNo: 1)!)
        initItemRow(rowNo: 2, textName: textItem3, labelQuantity: labelQuantity3, stepperQuantity: stepperQuantity3, shoppingListItem: shoppingList.getItemByRow(rowNo: 2)!)
        initItemRow(rowNo: 3, textName: textItem4, labelQuantity: labelQuantity4, stepperQuantity: stepperQuantity4, shoppingListItem: shoppingList.getItemByRow(rowNo: 3)!)
        initItemRow(rowNo: 4, textName: textItem5, labelQuantity: labelQuantity5, stepperQuantity: stepperQuantity5, shoppingListItem: shoppingList.getItemByRow(rowNo: 4)!)
    }
    
    /// init an item row that set its initial values and save its reference to "uiShoppinglist"
    private func initItemRow(rowNo: Int, textName: UITextField, labelQuantity: UILabel, stepperQuantity: UIStepper, shoppingListItem: ShoppingListItem) {
        var item = UIShoppingListItem(rowNo: rowNo, textName: textName, labelQuantity: labelQuantity, stepperQuantity: stepperQuantity,
        doSwipeLeftGesture: deleteItem, doSwipeRightGesture: addItemToFavourite)
        uiShoppinglist[rowNo] = item
        setItemRow(rowNo: rowNo, name: shoppingListItem.getName(), quantity: shoppingListItem.getQuantity())
    }
    
    /// set the values of an item row
    private func setItemRow(rowNo: Int, name: String, quantity: Int) {
        var item: UIShoppingListItem! = uiShoppinglist[rowNo]
        item.setName(name: name)
        item.setQuantity(quantity: quantity)
    }
    
    /// when stepper value changes, change the related item quantity according to the stepper value
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
    
    /// save the shopping list to the user perference and print it in the debug console
    @IBAction func btnSave_onTouchUpInside(_ sender: UIButton) {
        // if the shopping list name is empty, set a default name for it
        if (textShoppingListName.text == nil || textShoppingListName.text! == "") {
            textShoppingListName.text = "Shopping List"
        }
        // set the values of the saved shopping list by the values got from the UIs
        savedShoppingList.setName(name: textShoppingListName.text!)
        for i in 0 ... uiShoppinglist.count-1 {
            var item: ShoppingListItem! = savedShoppingList.getItemByRow(rowNo: i)
            // if item name is empty, discard any change of this item and do not save this item
            if (uiShoppinglist[i]!.getName() == "") {
                uiShoppinglist[i]!.setName(name: item.getName())
                uiShoppinglist[i]!.setQuantity(quantity: item.getQuantity())
            }
            else {
                item.setName(name: uiShoppinglist[i]!.getName())
                item.setQuantity(quantity: uiShoppinglist[i]!.getQuantity())
            }
        }
        shoppingListRepository.save(shoppingList: savedShoppingList)
        printShoppingListInDebugConsole(shoppingList: savedShoppingList)
    }
    
    /// print the shopping list to the debug console
    private func printShoppingListInDebugConsole(shoppingList: ShoppingList) {
        print("Shopping list name: " + shoppingList.getName())
        for item in shoppingList {
            if (item.getName() != "") {
                print("Item: " + item.getName() + "\t" + "Quantity: " + String(item.getQuantity()))
            }
        }
    }
    
    /// reset the values of the UIs of the shopping list to the values of the saved shopping list
    @IBAction func btnCancel_onTouchUpInside(_ sender: UIButton) {
        textShoppingListName.text = savedShoppingList.getName()
        var i = 0
        for item in savedShoppingList {
            setItemRow(rowNo: i, name: item.getName(), quantity: item.getQuantity())
            i += 1
        }
    }
    
    /// delete item on the shopping list (both UI and saved list)
    private func deleteItem(deletedItem: UIShoppingListItem) {
        let deletedItemRowNo = deletedItem.getRowNo()
        savedShoppingList.deleteItemByRow(rowNo: deletedItemRowNo) // delete the item from the saved list
        savedShoppingList.addItem(name: "", quantity: 0) // add an empty item at the back of the saved list
        shoppingListRepository.save(shoppingList: savedShoppingList) // save the updated list
        
        // shift the ui rows of the items below the deleted item
        var i = deletedItemRowNo+1
        while (i < uiShoppinglist.count) {
            let item: UIShoppingListItem! = uiShoppinglist[i]
            setItemRow(rowNo: i-1, name: item.getName(), quantity: item.getQuantity())
            i+=1
        }
        // edge case. clear the last ui row
        setItemRow(rowNo: uiShoppinglist.count-1, name: "", quantity: 0)
    }
    
    /// add item to the favourite list
    private func addItemToFavourite(item: UIShoppingListItem) {
        // do not add to favourite list if the item is already added to it
        for favouriteItem in favouriteItems {
            if (favouriteItem == item.getName()) {
                return
            }
        }
        favouriteItems.append(item.getName())
        favouriteItemsRepository.save(favouriteItems: favouriteItems)
    }
}

