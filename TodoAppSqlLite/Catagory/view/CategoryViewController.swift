//
//  CategoryViewController.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var categoryList = [CategoryModel]()
    var getTodoList = [TodoModel]()
    var categoryPresenterObjc: ViewToPresenterCategoryProtocol?
    var countPersonal = 0
    var countWork = 0
    var countMeeting = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewSizeSettings()
        CategoryRouter.createModule(ref: self)
    }
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    
    @IBAction func addNewTodoButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddNewTodo", sender: nil)
    }
    
    func collectionViewSizeSettings() {
        let desing = UICollectionViewFlowLayout()
        // Kenar boşlukları
        desing.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        // Yatay boşluk
        desing.minimumInteritemSpacing = 10
        // Diket boşluk
        desing.minimumLineSpacing = 10
        
        let width = collectionView.frame.size.width
        let horizantolHeight = ( width - 40 ) / 2
        desing.itemSize = CGSize(width: horizantolHeight, height: horizantolHeight)
        collectionView.collectionViewLayout = desing
    }
    
}


extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryList[indexPath.row]
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCategory", for: indexPath) as! CategoryCollectionViewCell
        item.categoryImageView.image = UIImage(systemName: category.categoryImageView!)
        item.labelCategoryTitle.text = category.categoryType
        item.labelCategoryTask.text = category.categoryCount
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row]
        performSegue(withIdentifier: "toAllList", sender: category)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? CategoryModel {
            let toVC = segue.destination as! TodoListViewController
            toVC.delegateTodoIndexFromCategory = self
            toVC.index = sender.typeId
            getTodoList = toVC.todoList
        }
    }

}
 
extension CategoryViewController: PresenterToViewCategoryProtocol {
    
    func dataTransferToView(todoList: Array<TodoModel>) {
        self.getTodoList = todoList
        for countTodo in self.getTodoList {
            if countTodo.todoType! == "Personal" {
                countPersonal += 1
            }else if countTodo.todoType! == "Work" {
                countWork += 1
            }else if countTodo.todoType! == "Meeting" {
                countMeeting += 1
            }
        }
        self.collectionView.reloadData()
    }
}


extension CategoryViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        categoryPresenterObjc?.load()
        categoryList.append(CategoryModel(typeId: 3, categoryType: "Personel", categoryImageView: "person", categoryCount: "\(countPersonal) Task"))
        categoryList.append(CategoryModel(typeId: 4, categoryType: "Work", categoryImageView: "network", categoryCount: "\(countWork) Task"))
        categoryList.append(CategoryModel(typeId: 5, categoryType: "Meeting", categoryImageView: "person.3", categoryCount: "\(countMeeting) Task"))
    }
}
