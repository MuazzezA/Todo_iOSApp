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
        copyDB()
        todoList = todoRepo.todoList
    }
    
    func deleteTodoInfo(id:Int){
        todoRepo.deleteTodoInfo(id: id)
        loadTodoData() // etkisi yok ??? 
       
    }
    
    func searchTodoInfo(searchText:String?){
        todoRepo.searchTodoInfo(searchText: searchText)
    }
    
    func loadTodoData(){
        todoRepo.loadTodoData()
    }
    
    func copyDB() {
        let bundlePath = Bundle.main.path(forResource: "todos", ofType: ".sqlite")
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let dbUrl = URL(fileURLWithPath: filePath).appendingPathComponent("todos.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: dbUrl.path()){
            print("db already exist")
        }else{
            do{
                try fm.copyItem(atPath: bundlePath!, toPath: dbUrl.path)
            }catch{
                print(error.localizedDescription)
            }
            
        }
        
    }
}
