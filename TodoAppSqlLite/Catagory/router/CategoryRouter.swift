//
//  CategoryRouter.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 1.09.2022.
//

import Foundation


class CategoryRouter: PresenterToRouterCategoryProtocol {
    
    static func createModule(ref: CategoryViewController) {
        let presenter = CategoryPresenter()
        ref.categoryPresenterObjc = presenter
        ref.categoryPresenterObjc?.categoryInteractor = CategoryInteractor()
        ref.categoryPresenterObjc?.categoryView = ref
        ref.categoryPresenterObjc?.categoryInteractor?.categoryPresenter = presenter
    }
    
    
}
