//
//  AddNewTodoViewController.swift
//  TodoAppSqlLite
//
//  Created by Berkay on 27.08.2022.
//

import UIKit

class AddNewTodoViewController: UIViewController {
    
    @IBOutlet weak var txtTodo: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var segmentedIndex: UISegmentedControl!
    var newTodoPresenterObject: ViewToPresenterNewTodoProtocol?
    var selectedSegmentedCategory: String?
    var datePicker: UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedSegmentedCategory = "Personal"
        NewTodoRouter.createModule(ref: self)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        txtDate.inputView = datePicker
        
        // Bu versyondan sonrakiler için bunu kullansın demek
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        
        let dokunmaAlgilama = UITapGestureRecognizer(target: self, action: #selector(dokunmaAlgilamaMetod))
        view.addGestureRecognizer(dokunmaAlgilama)
        
        datePicker?.addTarget(self, action: #selector(tarihGoster(uiDatePicker:)), for: .valueChanged)
    }
    
    @objc func tarihGoster(uiDatePicker: UIDatePicker) {
        let tarihFormati = DateFormatter()
        tarihFormati.dateFormat = "MM/dd/yyyy"
        let alinanTarih = tarihFormati.string(from: uiDatePicker.date)
        txtDate.text = alinanTarih
    }
    
    @objc func dokunmaAlgilamaMetod() {
        view.endEditing(true)
    }

    @IBAction func homeButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCategory", sender: nil)
    }
    
    @IBAction func segmentedCategory(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            selectedSegmentedCategory = "Personal"
        } else if index == 1 {
           selectedSegmentedCategory = "Work"
        } else {
            selectedSegmentedCategory = "Meeting"
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        if let todo = txtTodo.text, let todoDate = txtDate.text, let category = selectedSegmentedCategory {
            newTodoPresenterObject?.add(todo: todo, date: todoDate, category: category, isCompleted: "False")
            let alert = UIAlertController(title: "Todo added", message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
            txtTodo.text = ""
            txtDate.text = ""
            segmentedIndex.selectedSegmentIndex = 0
        }
    }
    
}
