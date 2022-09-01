//
//  CategoryModel.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import Foundation


class CategoryModel {
    
    var typeId: Int?
    var categoryType: String?
    var categoryImageView: String?
    var categoryCount: String?
    
    init(typeId: Int, categoryType: String, categoryImageView: String, categoryCount: String) {
        self.typeId = typeId
        self.categoryType = categoryType
        self.categoryImageView = categoryImageView
        self.categoryCount = categoryCount
    }
}
