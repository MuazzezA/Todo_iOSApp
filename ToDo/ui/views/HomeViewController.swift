//
//  HomeViewController.swift
//  ToDo
//
//  Created by Muazzez Aydın on 1.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todoTableView: UITableView!
    var mainTodoList:[Todo]?
    var todoList: [Todo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        todoList = [
        Todo(id: 0, title: "iOS Bootcamp", description: "Homework"),
        Todo(id: 1, title: "Work", description: "Task"),
        Todo(id: 2, title: "Home", description: "Homework"),
        Todo(id: 3, title: "Personal", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
        ]
        
        mainTodoList = todoList
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
    
    
    func filterTodos(with searchText: String) {
            if searchText.isEmpty {
                todoList = mainTodoList
            } else {
                todoList = mainTodoList?.filter { todoItem in
                    return todoItem.title!.lowercased().contains(searchText.lowercased())
                }
            }
            todoTableView.reloadData()
        }

}


extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search : \(searchText)")
        filterTodos(with: searchText)
    }
}



extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoList![indexPath.row]
        // burada nil olmayacağının garantisi aşağıda erişimi kolaylaştırır
        // todoItem.title kısmı
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! ToDoTableViewCell
        
        cell.todoTitleLabel.text = todoItem.title
        
        cell.todoDescLabel.text = todoItem.description!.count > 40 ? String(todoItem.description!.prefix(30)) + "..." : todoItem.description
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = todoList![indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: todoItem)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteContextualAction = UIContextualAction(style: .destructive, title: "Delete"){
            contextualAct, view, bool in
            let item = self.todoList![indexPath.row]
            
            let alert = UIAlertController(title: "Emin Misiniz?", message: "\(item.title!) notunuz silinecek.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            let yesAction = UIAlertAction(title: "Evet", style: .destructive) {
                action in
                print("\(item.title!) notu silindi.")
                
                self.todoList?.remove(at: item.id!)
                self.todoTableView.reloadData()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(yesAction)
            
            
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteContextualAction])
    }
    
}
