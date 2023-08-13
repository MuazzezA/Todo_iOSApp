//
//  SaveViewModel.swift
//  ToDo
//
//  Created by Muazzez Aydın on 13.08.2023.
//

import Foundation

class SaveViewModel {
    
    var todoRepo = TodoDaoRepo()
    
    func saveTodoInfo(titleText:String, descriptionText:String){
        todoRepo.saveTodoInfo(titleText: titleText, descriptionText: descriptionText)
    }
    
}
