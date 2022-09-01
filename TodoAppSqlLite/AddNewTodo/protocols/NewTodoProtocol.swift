//
//  NewTodoProtocol.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 31.08.2022.
//

import Foundation


protocol ViewToPresenterNewTodoProtocol {
    
    var newTodoInteractor: PresenterToInteractorNewTodoProtocol? { get set }
    func add(todo: String, date: String, category: String, isCompleted: String)
}

protocol PresenterToInteractorNewTodoProtocol {
    
    func addTodo(todo: String, date: String, category: String, isCompleted: String)
}

protocol PresenterToRouterNewTodoProtocol {
    
    static func createModule(ref: AddNewTodoViewController)
}
