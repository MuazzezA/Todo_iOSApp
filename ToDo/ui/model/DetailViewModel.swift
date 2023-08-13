//
//  DetailViewModel.swift
//  ToDo
//
//  Created by Muazzez Aydın on 13.08.2023.
//

import Foundation

class DetailViewModel{
    
    var todoRepo = TodoDaoRepo()
    
    func updateTodoInfo(new_titleText:String, new_descriptionText:String){
        todoRepo.updateTodoInfo(new_titleText: new_titleText, new_descriptionText: new_descriptionText)
    }
    
}
