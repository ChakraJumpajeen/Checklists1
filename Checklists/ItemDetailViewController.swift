//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Chakra Jumpajeen on 9/5/21.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController,didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController,didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var doneBarButton: UIBarButtonItem!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }

    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let item = itemToEdit {
          item.text = textField.text!
          delegate?.itemDetailViewController(self,didFinishEditing: item)
        } else {
          let item = ChecklistItem()
          item.text = textField.text!
          delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView,willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    class AddItemViewController: UITableViewController, UITextFieldDelegate {
        
    }
    // MARK: - Text Field Delegates
    // Page 500
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let oldText = textField.text!
      let stringRange = Range(range, in: oldText)!
      let newText = oldText.replacingCharacters(in: stringRange, with: string)
      doneBarButton.isEnabled = !newText.isEmpty
      return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}
