//
//  DetailViewController.swift
//  ToDo
//
//  Created by Muazzez Aydın on 1.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var todoItem:Todo?
    var viewModel = TodoDaoRepo()
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = "Id: " +  String(todoItem?.id ?? -1)
        titleTextField.text = todoItem?.title
        descriptionTextField.text = todoItem?.description
    }
    

    @IBAction func updateButtonAct(_ sender: Any) {
        if let title = titleTextField.text, let desc = descriptionTextField.text {
            updateTodoInfo(new_titleText: title, new_descriptionText: desc)
        }
    }
    
    func updateTodoInfo(new_titleText:String, new_descriptionText:String){
        viewModel.updateTodoInfo(new_titleText: new_titleText, new_descriptionText: new_descriptionText)
        
//        let alert = UIAlertController(title: "Güncellendi", message: "title : \(new_titleText) - description : \(new_descriptionText)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Tamam", comment: "Default action"), style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }
    
}
