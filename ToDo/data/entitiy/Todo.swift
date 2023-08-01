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
    
    init(id: Int? = nil, title: String? = nil, description: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
    }
 
}
