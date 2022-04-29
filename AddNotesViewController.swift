//
//  AddNotesViewController.swift
//  Taskty
//
//  Created by Anastasia Agustine on 29/04/22.
//

import UIKit


protocol AddTaskDelegate{
    func returnNewTask(_ taskName: String, _ taskPriority: Int, _ taskDate: String)
}

class AddNotesViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var prioritySC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create datepicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
        dateTextField.text = formatDate(date: datePicker.date)
        
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
    
    
    @IBAction func triggerSegueToTL(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newVC = segue.destination as? TaskListViewController {
            guard let addedName = nameTextField.text else {return}
            let newTask = TaskItem(name: addedName, date: dateTextField.text, priority: prioritySC.selectedSegmentIndex, notes: "")
            newVC.lists?.append(newTask)
        }
    }
    
}
