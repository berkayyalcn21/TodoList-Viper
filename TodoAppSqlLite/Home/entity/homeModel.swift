//
//  homeModel.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import Foundation
import UIKit


class HomeModel  {
    
    var homeModelId: Int?
    var imageViewCell: String?
    var labelTitle: String?
    var labelCount: String?
    
    init(homeModelId: Int, imageViewCell: String, labelTitle: String, labelCount: String) {
        self.homeModelId = homeModelId
        self.imageViewCell = imageViewCell
        self.labelTitle = labelTitle
        self.labelCount = labelCount
    }
}
