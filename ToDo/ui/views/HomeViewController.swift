//
//  HomeViewController.swift
//  ToDo
//
//  Created by Muazzez Aydın on 1.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

    var todoList:[Todo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList = [
        Todo(id: 0, title: "iOS Bootcamp", description: "Homework"),
        Todo(id: 1, title: "Work", description: "Task"),
        Todo(id: 2, title: "Home", description: "Homework"),
        Todo(id: 3, title: "Personal", description: "Task")
        ]
    }
    

    @IBAction func goToDetailButtonAct(_ sender: Any) {
        if let count = todoList?.count, count > 0 {
                let n = Int.random(in: 0..<count)
                performSegue(withIdentifier: "toDetail", sender: todoList![n])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetail"){
            if let item = sender as? Todo {
                let goDetail = segue.destination as! DetailViewController
                goDetail.todoItem = item
            }
        }
    }

}
