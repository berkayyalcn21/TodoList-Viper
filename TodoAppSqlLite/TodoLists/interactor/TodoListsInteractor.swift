//
//  TodoListsInteractor.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 29.08.2022.
//

import Foundation


class TodoListsInteractor: PresenterToInteractorTodoListsProtocol {
    
    var todoListsPresenter: InteractorToPresenterTodoListsProtocol?
    
    let db: FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        db = FMDatabase(path: kopyalanacakYer.path)
    }
    
    func getTodoList(index: Int) {
        
        var todoList = [TodoModel]()
        var searchQuery = "Select * from yapilacaklar"
        
        if index == 1 {
            searchQuery = "Select * from yapilacaklar where todoIsComplete = 'True'"
        } else if index == 2 {
            searchQuery = "Select * from yapilacaklar where todoIsComplete = 'False'"
        } else if index == 3 {
            searchQuery = "Select * from yapilacaklar where todoType = 'Personal'"
        } else if index == 4 {
            searchQuery = "Select * from yapilacaklar where todoType = 'Work'"
        } else if index == 5 {
            searchQuery = "Select * from yapilacaklar where todoType = 'Meeting'"
        }
        
        db?.open()
        
        do {
            let query = try db!.executeQuery(searchQuery, values: nil)
            while query.next() {
                let todo = TodoModel(todoId: Int(query.string(forColumn: "todoId"))!,
                                     todo: query.string(forColumn: "todo")!,
                                     todoType: query.string(forColumn: "todoType")!,
                                     todoIsComplete: query.string(forColumn: "todoIsComplete")!,
                                     todoDate: query.string(forColumn: "todoDate")!)
                todoList.append(todo)
            }
            todoListsPresenter?.dataTransferToPresenter(todoList: todoList)
            
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func todoGuncelle(todoId: Int, todoIsComplete: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE yapilacaklar SET todoIsComplete = ? WHERE todoId = ?", values: [todoIsComplete, todoId])
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func todoAra(searchText: String) {
        
        var todoList = [TodoModel]()
        db?.open()
        
        do {
            let query = try db!.executeQuery("Select * from yapilacaklar where todo like '%\(searchText)%'", values: nil)
            while query.next() {
                let todo = TodoModel(todoId: Int(query.string(forColumn: "todoId"))!,
                                     todo: query.string(forColumn: "todo")!,
                                     todoType: query.string(forColumn: "todoType")!,
                                     todoIsComplete: query.string(forColumn: "todoIsComplete")!,
                                     todoDate: query.string(forColumn: "todoDate")!)
                todoList.append(todo)
            }
            todoListsPresenter?.dataTransferToPresenter(todoList: todoList)
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func todoSil(todoId: Int) {
        db?.open()
        
        do {
            try db!.executeUpdate("Delete from yapilacaklar where todoId = ?", values: [todoId])
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func todoDataUpdate(todoId: Int, todo: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE yapilacaklar SET todo = ? WHERE todoId = ?", values: [todo, todoId])
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
