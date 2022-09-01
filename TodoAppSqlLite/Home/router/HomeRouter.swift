//
//  HomeRouter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 28.08.2022.
//

import Foundation


class HomeRouter: PresenterToRouterHomeProtocol {
    
    static func createModul(ref: ViewController) {
        let presenter = HomePresenter()
        ref.homePresenterObjc = presenter
        ref.homePresenterObjc?.homeInteractor = HomeInteractor()
        ref.homePresenterObjc?.homeView = ref
        ref.homePresenterObjc?.homeInteractor?.homePresenter = presenter
    }
    
    
}
