//
//  DetailViewModel.swift
//  ToDo
//
//  Created by Muazzez Aydın on 13.08.2023.
//

import Foundation

class DetailViewModel{
    
    var todoRepo = TodoDaoRepo()
    
    func updateTodoInfo(todo_id:Int ,new_titleText:String, new_descriptionText:String){
        todoRepo.updateTodoInfo(todo_id:todo_id, new_titleText: new_titleText, new_descriptionText: new_descriptionText)
    }
    
}
