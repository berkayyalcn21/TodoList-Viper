//
//  NewTodoRouter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 31.08.2022.
//

import Foundation


class NewTodoRouter: PresenterToRouterNewTodoProtocol {
    
    static func createModule(ref: AddNewTodoViewController) {
        ref.newTodoPresenterObject = NewTodoPresenter()
        ref.newTodoPresenterObject?.newTodoInteractor = NewTodoInteractor()
    }
}
