//
//  homeProtocols.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 28.08.2022.
//

import Foundation


// Main Protocols

protocol ViewToPresenterHomeProtocol {
    
    var homeInteractor: PresenterToInteractorHomeProtocol? { get set}
    var homeView: PresenterToViewHomeProtocol? { get set }
    func load()
}

protocol PresenterToInteractorHomeProtocol {
    
    var homePresenter: InteractorToPresenterHomeProtocol? { get set }
    func loadTodo()
}


// Transporter Protocols

protocol InteractorToPresenterHomeProtocol {
    
    func dataTransferToPresenter(todoList: Array<TodoModel>)
}

protocol PresenterToViewHomeProtocol {
    
    func dataTransferToView(todoList: Array<TodoModel>)
}

// Router

protocol PresenterToRouterHomeProtocol {
    static func createModul(ref: ViewController)
}

