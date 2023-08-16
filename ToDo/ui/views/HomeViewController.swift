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

    var todoList: [Todo]?
    
    var viewModel = TodoDaoRepo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        
        _ = viewModel.todoList.subscribe(onNext: { liste in
            self.todoList = liste
            self.todoTableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadTodoData()
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


extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTodoInfo(searchText: searchText)
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
                //print("\(item.title!) notu silindi.")
                self.viewModel.deleteTodoInfo(id: item.id!)
                
                //self.todoList?.remove(at: item.id!)
                //self.todoTableView.reloadData()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(yesAction)
            
            
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteContextualAction])
    }
    
}
