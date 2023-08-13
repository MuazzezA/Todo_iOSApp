//
//  TodoDao.swift
//  ToDo
//
//  Created by Muazzez Aydın on 13.08.2023.
//

import Foundation


class TodoDaoRepo {
    
    
    func saveTodoInfo(titleText:String, descriptionText:String){
        print("repo:TODO SAVE: \(titleText) - \(descriptionText)")
    }
    
    func updateTodoInfo(new_titleText:String, new_descriptionText:String){
       print("repo:TODO Update \(new_titleText)")
    }
}
