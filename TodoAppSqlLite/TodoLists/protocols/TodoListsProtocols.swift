//
//  TodoListsProtocols.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 29.08.2022.
//

import Foundation


protocol ViewToPresenterTodoListsProtocol {
        
    var todoListsInteractor: PresenterToInteractorTodoListsProtocol? { get set }
    var todoListsView: PresenterToViewTodoListsProtocol? { get set }
    func list(index: Int)
    func guncelle(todoId: Int, todoIsComplete: String)
    func ara(searchText: String)
    func sil(todoId: Int)
    func dataUpdate(todoId: Int, todo: String)
}

protocol PresenterToInteractorTodoListsProtocol {
    
    var todoListsPresenter: InteractorToPresenterTodoListsProtocol? { get set }
    func getTodoList(index: Int)
    func todoGuncelle(todoId: Int, todoIsComplete: String)
    func todoAra(searchText: String)
    func todoSil(todoId: Int)
    func todoDataUpdate(todoId: Int, todo: String)
}

protocol PresenterToRouterTodoListsProtocol {
    
    static func createModule(ref: TodoListViewController)
}

protocol InteractorToPresenterTodoListsProtocol {
    func dataTransferToPresenter(todoList: Array<TodoModel>)
}

protocol PresenterToViewTodoListsProtocol {
    func dataTransferToView(todoList: Array<TodoModel>)
}
