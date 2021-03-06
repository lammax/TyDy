//
//  TyDyListSceneViewController.swift
//  TyDy
//
//  Created by Mac on 25/01/2019.
//  Copyright (c) 2019 Lammax. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TyDyListSceneDisplayLogic: class {
    func displayAddItem(viewModel: TyDyListScene.AddItem.ViewModel)
    func displaySaveItem(viewModel: TyDyListScene.SaveNewItem.ViewModel)
    func displayLoadData(viewModel: TyDyListScene.LoadData.ViewModel)
    func displayUpdateData(viewModel: TyDyListScene.UpdateData.ViewModel)
    func displaySaveData(viewModel: TyDyListScene.SaveData.ViewModel)
}

class TyDyListSceneViewController: UITableViewController {
    // MARK: Vars
    var interactor: TyDyListSceneBusinessLogic?
    var router: (NSObjectProtocol & TyDyListSceneRoutingLogic & TyDyListSceneDataPassing)?
    
    // MARK: Outlets
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        TyDyListSceneConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
          let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
          if let router = router, router.responds(to: selector) {
            router.perform(selector, with: segue)
          }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }

    // MARK: Do something
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        self.addItem()
    }
    
    func addItem() {
        let request = TyDyListScene.AddItem.Request()
        interactor?.addItem(request: request)
    }

    func saveItem(item: TyDyItem) {
        let request = TyDyListScene.SaveNewItem.Request(
            item: item
        )
        interactor?.saveItem(request: request)
    }
    
    func loadData() {
        let request = TyDyListScene.LoadData.Request()
        interactor?.loadData(request: request)
    }

    func updateData() {
        let request = TyDyListScene.UpdateData.Request()
        interactor?.updateData(request: request)
    }

    func saveData() {
        let request = TyDyListScene.SaveData.Request()
        interactor?.saveData(request: request)
    }
    
}

extension TyDyListSceneViewController: TyDyListSceneDisplayLogic {
    
    func displayAddItem(viewModel: TyDyListScene.AddItem.ViewModel) {
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // here is whart will happen when user once click Add Item
            if let text = alert.textFields?.first?.text {
                self.saveItem(item: TyDyItem(title: text, done: false))
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Type new item here"
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func displaySaveItem(viewModel: TyDyListScene.SaveNewItem.ViewModel) {
        self.tableView.reloadData()
    }
    
    func displayLoadData(viewModel: TyDyListScene.LoadData.ViewModel) {
        self.tableView.reloadData()
    }
    
    func displayUpdateData(viewModel: TyDyListScene.UpdateData.ViewModel) {
         self.tableView.reloadData()
    }
    
    func displaySaveData(viewModel: TyDyListScene.SaveData.ViewModel) {
        //do something on SaveData action
    }
    
}

extension TyDyListSceneViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.router?.dataStore?.itemArray?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentItem = self.router?.dataStore?.itemArray?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = currentItem?.title
        cell.accessoryType = (currentItem?.done != nil && (currentItem?.done)!) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        let done = self.router?.dataStore?.itemArray?[indexPath.row].done != nil && (self.router?.dataStore?.itemArray?[indexPath.row].done)!
        self.router?.dataStore?.itemArray?[indexPath.row].done = !done
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveData()
        self.updateData()
    }
    
}
