//
//  ViewController.swift
//  Todoey
//
//  Created by LaDonna Handugan on 4/15/19.
//  Copyright © 2019 LaDonna Handugan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["apples", "pie", "coconuts"]
//    var itemArray = [String]()
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item(itemTitle: "apples")
        itemArray.append(newItem)

        let newItem2 = Item(itemTitle: "pie")
        newItem2.done = true
        itemArray.append(newItem2)

        let newItem3 = Item(itemTitle: "coconuts")
        itemArray.append(newItem3)
        

        // doesn't work
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let textField = alert.textFields![0] as UITextField
            
            //TODO - Check if text field is "" or "(spaces)"
            self.itemArray.append(Item(itemTitle: textField.text!))
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            print("Item Added!")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Todoey Item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

