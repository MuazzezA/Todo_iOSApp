//
//  Todos.swift
//  ToDo
//
//  Created by Muazzez Aydın on 1.08.2023.
//

import Foundation

class Todo {

    var id:Int?
    var title:String?
    var description:String?
    
    init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
 
}
