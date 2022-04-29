//
//  TaskDetailViewController.swift
//  Taskty
//
//  Created by Anastasia Agustine on 28/04/22.
//

import UIKit

protocol TaskDetailDelegate {
    func getSavedTask(_ newName: String, _ newPriority: Int, _ index: Int, _ date: String)
}

class TaskDetailViewController: UIViewController {
    var delegate: TaskDetailDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var taskPriorityControl: UISegmentedControl!
    
    //declare data
    var taskData: TaskItem?
    var dataIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("opened task with index: \(dataIndex!)")
        
        //create datepicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
        dateTextField.text = formatDate(date: datePicker.date)

        //connect the fields with the task datas
        nameTextField.text = taskData?.name
        if let taskDate = taskData?.date{
            dateTextField?.text = taskDate
        } else {
            dateTextField?.text = ""
        }
        if let taskPriority = taskData?.priority{
            taskPriorityControl.selectedSegmentIndex = taskPriority
        } else {
            taskPriorityControl.selectedSegmentIndex = 0
        }
    }
    
    
    //datepicker functions
    @objc func dateChange(datePicker: UIDatePicker){
        dateTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    //return delegate when pressing save button
    @IBAction func saveTask (_ sender: Any){
        guard let textField = nameTextField.text else{
            fatalError("Task is Empty")
        }
        guard let index = dataIndex else{
            fatalError("index is nil")
        }
        guard let date = dateTextField.text else {return}
        
        delegate?.getSavedTask(textField, taskPriorityControl.selectedSegmentIndex, index, date)
        print(delegate as Any)
        _ = navigationController?.popViewController(animated: true)
    }
}
