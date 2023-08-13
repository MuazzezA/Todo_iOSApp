//
//  TodoDao.swift
//  ToDo
//
//  Created by Muazzez Aydın on 13.08.2023.
//

import Foundation
import RxSwift

class TodoDaoRepo {
    
    var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    func saveTodoInfo(titleText:String, descriptionText:String){
        print("repo:TODO SAVE: \(titleText) - \(descriptionText)")
    }
    
    func updateTodoInfo(new_titleText:String, new_descriptionText:String){
       print("repo:TODO Update \(new_titleText)")
    }
    
    func deleteTodoInfo(id:Int){
        print("repo:TODO Delete id: \(id)")
    }
    
    func searchTodoInfo(searchText:String?){
        print("repo:Search : \(searchText ?? "")")
    }
    
    
    func loadTodoData(){
        
        let todoListData = [
        Todo(id: 0, title: "iOS Bootcamp", description: "Homework"),
        Todo(id: 1, title: "Work", description: "Task"),
        Todo(id: 2, title: "Home", description: "Homework"),
        Todo(id: 3, title: "Personal", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
        ]
        
        todoList.onNext(todoListData)
    }
    
}
