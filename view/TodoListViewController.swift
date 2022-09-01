//
//  TodoListViewController.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var todoListsInfoPresenterObject: ViewToPresenterTodoListsProtocol?
    var todoList = [TodoModel]()
    weak var delegateTodoIndex: ViewController?
    weak var delegateTodoIndexFromCategory: CategoryViewController?
    @IBOutlet weak var searchBar: UISearchBar!
    var index: Int?
    var datePicker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        searchBar.delegate = self
        veritabaniKopyalama()
        TodoListsRouter.createModule(ref: self)
        
        let dokunmaAlgilama = UITapGestureRecognizer(target: self, action: #selector(dokunmaAlgilamaMetod))
        view.addGestureRecognizer(dokunmaAlgilama)
    }
    
    @objc func dokunmaAlgilamaMetod() {
        view.endEditing(true)
    }
    
    @IBAction func isCompleteButton(_ sender: UIButton) {
        for i in todoList {
            if i.todoId == sender.tag && i.todoIsComplete == "False" {
                todoListsInfoPresenterObject?.guncelle(todoId: sender.tag, todoIsComplete: "True")
            } else if i.todoId == sender.tag && i.todoIsComplete == "True" {
                todoListsInfoPresenterObject?.guncelle(todoId: sender.tag, todoIsComplete: "False")
            }
        }
        todoListsInfoPresenterObject?.list(index: index!)
    }
    
    func veritabaniKopyalama() {
        let bundleYolu = Bundle.main.path(forResource: "todoApp", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        let fm  = FileManager.default
        if fm .fileExists(atPath: kopyalanacakYer.path) {
            print("")
        }else {
            do {
                try fm.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoListsInfoPresenterObject?.list(index: index!)
    }

    @IBAction func homeButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    
    @IBAction func addNewTodoButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddNewTodo", sender: nil)
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCategory", sender: nil)
    }

}


extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        cell.lblTodoTitle.text = todo.todo
        cell.lblTodoType.text = todo.todoType
        cell.lblTodoDate.text = todo.todoDate
        cell.isCompleteButton.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        cell.isCompleteButton.tintColor = UIColor.placeholderText
        cell.isCompleteButton.tag = todo.todoId ?? 0
        if todo.todoIsComplete == "True" {
            cell.isCompleteButton.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            cell.isCompleteButton.tintColor = UIColor(named: "techCarrerColor")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todo = self.todoList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            let alert = UIAlertController(title: "Delete", message: "Do you want to delete ?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let eventAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.todoListsInfoPresenterObject?.sil(todoId: todo.todoId!)
                self.todoListsInfoPresenterObject?.list(index: self.index!)
            }
            alert.addAction(cancelAction)
            alert.addAction(eventAction)
            self.present(alert, animated: true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { contextualAction, view, bool in
            let alertController = UIAlertController(title: "EDIT", message: "", preferredStyle: .alert)
            alertController.addTextField { tf in
                tf.placeholder = "Todo"
            }
            let update = UIAlertAction(title: "Update", style: .cancel) { action in
                let tf = alertController.textFields![0] as UITextField
                if let tf = tf.text {
                    self.todoListsInfoPresenterObject?.dataUpdate(todoId: todo.todoId!, todo: tf)
                    self.todoListsInfoPresenterObject?.list(index: self.index!)
                }
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .default)
            alertController.addAction(cancelButton)
            alertController.addAction(update)
            self.present(alertController, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    
}

extension TodoListViewController: PresenterToViewTodoListsProtocol {
    func dataTransferToView(todoList: Array<TodoModel>) {
        self.todoList = todoList.reversed()
        self.todoTableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        todoListsInfoPresenterObject?.ara(searchText: searchText)
    }
}
