//
//  NewTodoInteractor.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 31.08.2022.
//

import Foundation


class NewTodoInteractor: PresenterToInteractorNewTodoProtocol {
    
    let db: FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        db = FMDatabase(path: kopyalanacakYer.path)
    }
    
    func addTodo(todo: String, date: String, category: String, isCompleted: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO yapilacaklar (todo, todoType, todoIsComplete, todoDate) VALUES (?, ?, ?, ?)", values: [todo, category, isCompleted, date])
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
