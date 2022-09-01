//
//  NewTodoPresenter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 31.08.2022.
//

import Foundation


class NewTodoPresenter: ViewToPresenterNewTodoProtocol {
    
    var newTodoInteractor: PresenterToInteractorNewTodoProtocol?
    
    func add(todo: String, date: String, category: String, isCompleted: String) {
        newTodoInteractor?.addTodo(todo: todo, date: date, category: category, isCompleted: isCompleted)
    }
}
