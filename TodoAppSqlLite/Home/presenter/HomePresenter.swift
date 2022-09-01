//
//  HomePresenter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 28.08.2022.
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteractorHomeProtocol?
    var homeView: PresenterToViewHomeProtocol?
    
    func load() {
        homeInteractor?.loadTodo()
    }
}


extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func dataTransferToPresenter(todoList: Array<TodoModel>) {
        homeView?.dataTransferToView(todoList: todoList)
    }
    
}
