//
//  CategoryProtocols.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 1.09.2022.
//

import Foundation


// Main Protocols

protocol ViewToPresenterCategoryProtocol {
    
    var categoryInteractor: PresenterToInteractorCategoryProtocol? { get set }
    var categoryView: PresenterToViewCategoryProtocol? { get set }
    func load()
}

protocol PresenterToInteractorCategoryProtocol {
    
    var categoryPresenter: InteractorToPresenterCategoryProtocol? { get set }
    func loadTodo()
}


// Transporter Protocols

protocol InteractorToPresenterCategoryProtocol {
    
    func dataTransferToPresenter(todoList: Array<TodoModel>)
}

protocol PresenterToViewCategoryProtocol {
    
    func dataTransferToView(todoList: Array<TodoModel>)
}

// Router

protocol PresenterToRouterCategoryProtocol {
    static func createModule(ref: CategoryViewController)
}
