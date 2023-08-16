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
    
    let db:FMDatabase?
    
    init(){
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let dbUrl = URL(fileURLWithPath: filePath).appendingPathComponent("todos.sqlite")
        
        db = FMDatabase(path: dbUrl.path)
    }
    
    func saveTodoInfo(titleText:String, descriptionText:String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO todos (todo_title,todo_content) VALUES (?,?)", values: [titleText, descriptionText])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func updateTodoInfo(todo_id:Int, new_titleText:String, new_descriptionText:String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE todos SET todo_title = ?, todo_content = ? WHERE todo_id = ?", values: [new_titleText, new_descriptionText, todo_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func deleteTodoInfo(id:Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM todos WHERE todo_id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func searchTodoInfo(searchText:String?){
        
        db?.open()
        
        var todoListData = [Todo]();
        do{
            let result = try db!.executeQuery("select * from todos where todo_title = '%\(searchText!)%'", values: nil)
            
            while result.next() {
                let todo_id = Int(result.string(forColumn: "todo_id"))!
                let todo_title = result.string(forColumn: "todo_title")!
                let todo_desc = result.string(forColumn: "todo_content")!
                let item = Todo(id: todo_id, title: todo_title, description: todo_desc)
                
                todoListData.append(item)
            }
            todoList.onNext(todoListData)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    
    func loadTodoData(){
        
        db?.open()
        
        var todoListData = [Todo]();
        do{
            let result = try db!.executeQuery("select * from todos", values: nil)
            while result.next() {
                let todo_id = Int(result.string(forColumn: "todo_id"))!
                let todo_title = result.string(forColumn: "todo_title")!
                let todo_desc = result.string(forColumn: "todo_content")!
                let item = Todo(id: todo_id, title: todo_title, description: todo_desc)
                todoListData.append(item)
            }
            
            todoList.onNext(todoListData)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
}
