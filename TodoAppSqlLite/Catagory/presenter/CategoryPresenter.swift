//
//  CategoryPresenter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 1.09.2022.
//

import Foundation


class CategoryPresenter: ViewToPresenterCategoryProtocol {
    
    var categoryInteractor: PresenterToInteractorCategoryProtocol?
    var categoryView: PresenterToViewCategoryProtocol?
    
    func load() {
        categoryInteractor?.loadTodo()
    }
    
    
}

extension CategoryPresenter: InteractorToPresenterCategoryProtocol {
    
    func dataTransferToPresenter(todoList: Array<TodoModel>) {
        categoryView?.dataTransferToView(todoList: todoList)
    }
    
}
