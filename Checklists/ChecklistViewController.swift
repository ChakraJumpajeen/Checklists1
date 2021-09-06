//
//  ViewController.swift
//  Checklists
//
//  Created by Chakra Jumpajeen on 9/2/21.
//

import UIKit

//class ViewController: UIViewController {
//class ChecklistViewController: UITableViewController {
class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
      navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
      let newRowIndex = items.count
      items.append(item)

      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)

      navigationController?.popViewController(animated: true)
    }
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
    }
    
    var row0item = ChecklistItem()
    var row1item = ChecklistItem()
    var row2item = ChecklistItem()
    var row3item = ChecklistItem()
    var row4item = ChecklistItem()
    var items = [ChecklistItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let item1 = ChecklistItem()
          item1.text = "Walk the dog"
          items.append(item1)
        let item2 = ChecklistItem()
          item2.text = "Brush my teeth"
          item2.checked = true
          items.append(item2)
        let item3 = ChecklistItem()
          item3.text = "Learn iOS development"
          item3.checked = true
          items.append(item3)
        let item4 = ChecklistItem()
          item4.text = "Soccer practice"
          items.append(item4)
        let item5 = ChecklistItem()
          item5.text = "Eat ice cream"
          items.append(item5)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
/*
    @IBAction func addItem() {
        let newRowIndex = items.count
        let item = ChecklistItem()
        item.text = "I am a new row"
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
*/
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt    indexPath: IndexPath){
        // 1
        items.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem){
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    func configureText(for cell: UITableViewCell,with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?){
        // 1
        if segue.identifier == "AddItem" {
            // 2
            let controller = segue.destination as!ItemDetailViewController
            // 3
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as!ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
              controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    func addItemViewController(_ controller: ItemDetailViewController,
                               didFinishEditing item: ChecklistItem){
        if let index = items.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at:indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
