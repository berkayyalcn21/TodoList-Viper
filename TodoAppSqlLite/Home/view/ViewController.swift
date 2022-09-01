//
//  ViewController.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var homeModelList = [HomeModel]()
    var todoModelList = [TodoModel]()
    var homePresenterObjc: ViewToPresenterHomeProtocol?
    
    var countTrue = 0
    var countFalse = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Satırlar arasındaki çizginin rengini ayarlama
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        copyDatabase()
        HomeRouter.createModul(ref: self)
    }
    
    @IBAction func addNewTodoButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddNewTodo", sender: nil)
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCategory", sender: nil)
    }
    
    func copyDatabase() {
        let bundleYolu = Bundle.main.path(forResource: "todoApp", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        let fm  = FileManager.default
        if fm .fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var")
        }else {
            do {
                try fm.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = homeModelList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeTableViewCell
        cell.imageViewCell.image = UIImage(systemName: homeCell.imageViewCell!)
        cell.labelTitle.text = homeCell.labelTitle
        cell.labelCount.text = homeCell.labelCount
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homelModel = homeModelList[indexPath.row]
        performSegue(withIdentifier: "toAllList", sender: homelModel)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? HomeModel {
            let toVC = segue.destination as! TodoListViewController
            toVC.delegateTodoIndex = self
            toVC.index = sender.homeModelId
        }
    }
    
}


extension ViewController: PresenterToViewHomeProtocol {
    
    func dataTransferToView(todoList: Array<TodoModel>) {
        self.todoModelList = todoList
        for countTodo in self.todoModelList {
            if countTodo.todoIsComplete! == "False" {
                countFalse += 1
            }else if countTodo.todoIsComplete! == "True" {
                countTrue += 1
            }
        }
        self.tableView.reloadData()
    }
    
    
}

extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        homePresenterObjc?.load()
        homeModelList.append(HomeModel(homeModelId: 0, imageViewCell: "folder", labelTitle: "Tüm Liste", labelCount: String(self.todoModelList.count)))
        homeModelList.append(HomeModel(homeModelId: 1, imageViewCell: "checkmark", labelTitle: "Tamamlandı", labelCount: String(countTrue)))
        homeModelList.append(HomeModel(homeModelId: 2, imageViewCell: "hourglass.bottomhalf.filled", labelTitle: "Devam Eden Çalışma", labelCount: String(countFalse)))
        
    }
}
