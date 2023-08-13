//
//  SaveViewController.swift
//  ToDo
//
//  Created by Muazzez Aydın on 1.08.2023.
//

import UIKit

class SaveViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    var viewModel = TodoDaoRepo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonAct(_ sender: Any) {
        if let title = titleTextField.text, let desc = descTextField.text  {
           saveTodoInfo(titleText: title, descriptionText: desc)
        }
        
    }
    
    func saveTodoInfo(titleText:String, descriptionText:String){
        let alert = UIAlertController(title: "Kaydedildi", message: "title : \(titleText) - description : \(descriptionText)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Tamam", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        viewModel.saveTodoInfo(titleText: titleText, descriptionText: descriptionText)
        
    }
}
