//
//  TodoModel.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 28.08.2022.
//

import Foundation


class TodoModel {
    
    var todoId: Int?
    var todo: String?
    var todoType: String?
    var todoIsComplete: String?
    var todoDate: String?
    
    init(todoId: Int, todo: String, todoType: String, todoIsComplete: String, todoDate: String) {
        self.todoId = todoId
        self.todo = todo
        self.todoType = todoType
        self.todoIsComplete = todoIsComplete
        self.todoDate = todoDate
    }
}
