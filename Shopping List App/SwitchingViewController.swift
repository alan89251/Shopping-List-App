//
//  SwitchingViewController.swift
//  Shopping List App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 30/10/2022
//  Changes: Implement the logic for the UI controls
//

import UIKit

/// view controller for switching view
class SwitchingViewController: UIViewController {
    private var shoppingListViewController: ShoppingListViewController?
    private var favouriteItemsViewController: FavouriteItemsViewController?
    
    @IBOutlet weak var btnSwitchView: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingListViewController = storyboard?.instantiateViewController(withIdentifier: "shoppingList") as! ShoppingListViewController
        shoppingListViewController!.view.frame = view.frame
        switchViewContoller(from: nil, to: shoppingListViewController)
    }

    /// switch from one view to another view
    private func switchViewContoller(from fromVC: UIViewController?, to toVC: UIViewController?) {
        if (fromVC != nil) {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if (toVC != nil) {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }
    
    /// switch between the shopping list view and the favourite items view
    @IBAction func btnSwitchView_onPressed(_ sender: UIBarButtonItem) {
        // create the new view controller, if required
        if (shoppingListViewController?.view.superview == nil) {
            if (shoppingListViewController == nil) {
                shoppingListViewController = storyboard?.instantiateViewController(withIdentifier: "shoppingList") as! ShoppingListViewController
            }
        }
        else if (favouriteItemsViewController?.view.superview == nil) {
            if (favouriteItemsViewController == nil) {
                favouriteItemsViewController = storyboard?.instantiateViewController(withIdentifier: "favouriteItems") as! FavouriteItemsViewController
            }
        }
        
        // Switch view controllers
        if (favouriteItemsViewController != nil
            && favouriteItemsViewController!.view.superview != nil) {
            btnSwitchView.title = "View Favourite Items"
            shoppingListViewController!.view.frame = view.frame
            switchViewContoller(from: favouriteItemsViewController, to: shoppingListViewController)
        }
        else {
            btnSwitchView.title = "Shopping List"
            favouriteItemsViewController!.view.frame = view.frame
            switchViewContoller(from: shoppingListViewController, to: favouriteItemsViewController)
        }
    }
}
