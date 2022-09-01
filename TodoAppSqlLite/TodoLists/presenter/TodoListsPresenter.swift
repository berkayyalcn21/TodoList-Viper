//
//  TodoListsPresenter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 29.08.2022.
//

import Foundation


class TodoListsPresenter: ViewToPresenterTodoListsProtocol {
    
    var todoListsInteractor: PresenterToInteractorTodoListsProtocol?
    var todoListsView: PresenterToViewTodoListsProtocol?
    
    func list(index: Int) {
        todoListsInteractor?.getTodoList(index: index)
    }
    
    func guncelle(todoId: Int, todoIsComplete: String) {
        todoListsInteractor?.todoGuncelle(todoId: todoId, todoIsComplete: todoIsComplete)
    }
    
    func ara(searchText: String) {
        todoListsInteractor?.todoAra(searchText: searchText)
    }
    
    func sil(todoId: Int) {
        todoListsInteractor?.todoSil(todoId: todoId)
    }
    
    func dataUpdate(todoId: Int, todo: String) {
        todoListsInteractor?.todoDataUpdate(todoId: todoId, todo: todo)
    }
    
}

extension TodoListsPresenter: InteractorToPresenterTodoListsProtocol {
    
    func dataTransferToPresenter(todoList: Array<TodoModel>) {
        todoListsView?.dataTransferToView(todoList: todoList)
    }
}
