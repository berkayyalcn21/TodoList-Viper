//
//  TodoListsRouter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 29.08.2022.
//

import Foundation


class TodoListsRouter: PresenterToRouterTodoListsProtocol {
    
    static func createModule(ref: TodoListViewController) {
        let presenter = TodoListsPresenter()
        
        // View
        ref.todoListsInfoPresenterObject = presenter
        
        // Presenter
        ref.todoListsInfoPresenterObject?.todoListsView = ref
        ref.todoListsInfoPresenterObject?.todoListsInteractor = TodoListsInteractor()
        
        // Interactor
        ref.todoListsInfoPresenterObject?.todoListsInteractor?.todoListsPresenter = presenter
        
    }
}
