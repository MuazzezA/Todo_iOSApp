//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Muazzez Aydın on 13.08.2023.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var todoRepo = TodoDaoRepo()
    var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    init(){
        
        todoList = todoRepo.todoList
    }
    
    func deleteTodoInfo(id:Int){
        todoRepo.deleteTodoInfo(id: id)
    }
    
    func searchTodoInfo(searchText:String?){
        todoRepo.searchTodoInfo(searchText: searchText)
    }
    
    func loadTodoData(){
        todoRepo.loadTodoData()
    }
}
