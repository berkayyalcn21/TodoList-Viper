//
//  CategoryInteractor.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 1.09.2022.
//

import Foundation


class CategoryInteractor: PresenterToInteractorCategoryProtocol {
    
    var categoryPresenter: InteractorToPresenterCategoryProtocol?
    
    let db: FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        db = FMDatabase(path: kopyalanacakYer.path)
    }
    
    func loadTodo() {
        var todoList = [TodoModel]()
        db?.open()
        
        do {
            let query = try db!.executeQuery("Select * from yapilacaklar", values: nil)
            while query.next() {
                let todo = TodoModel(todoId: Int(query.string(forColumn: "todoId"))!,
                                   todo: query.string(forColumn: "todo")!,
                                   todoType: query.string(forColumn: "todoType")!,
                                     todoIsComplete: query.string(forColumn: "todoIsComplete")!,
                                     todoDate: query.string(forColumn: "todoDate")!)
                todoList.append(todo)
            }
            categoryPresenter?.dataTransferToPresenter(todoList: todoList)
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
}
