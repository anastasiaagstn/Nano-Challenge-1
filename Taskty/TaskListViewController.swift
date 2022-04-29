//
//  TaskListViewController.swift
//  Taskty
//
//  Created by Anastasia Agustine on 28/04/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    
    var lists: [TaskItem]?
    let taskFeed = taskFeeder()
    var rowSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //input the data model
        lists = taskFeed.feeder()
        
        //declare table cells
        taskTableView.register(UINib(nibName: "TaskListTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    @IBAction func segueToAddNotes(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "moveToAddNotes", sender: self)
    }
    
    @IBAction func unwindToTaskList( _ seg: UIStoryboardSegue) {
        taskTableView.reloadData()
    }
}


extension TaskListViewController: UITableViewDelegate, UITableViewDataSource{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            if let selectedRow  = rowSelected {
                guard let newVC = segue.destination as? TaskDetailViewController else {return}
                newVC.taskData = lists?[selectedRow]
                newVC.dataIndex = selectedRow
                newVC.delegate = self
            }
        } else if segue.identifier == "moveToAddNotes" {
            guard let newVC = segue.destination as? AddNotesViewController else {return}
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell") as? TaskListTableViewCell
        cell?.taskLabel.text = lists?[indexPath.row].name
        cell?.dateLabel.text = lists?[indexPath.row].date
        let colors: [UIColor] = [UIColor.systemGreen, UIColor.systemYellow, UIColor.systemRed]
        if let priorityIndex = lists?[indexPath.row].priority{
            cell?.priorityColorImage.backgroundColor = colors[priorityIndex]
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = lists?.count {
            return count
        }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "moveToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            lists?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}


extension TaskListViewController: TaskDetailDelegate {
    func getSavedTask(_ newName: String, _ newPriority: Int, _ index: Int, _ date: String) {
        lists?[index].name = newName
        lists?[index].priority = newPriority
        lists?[index].date = date
        self.taskTableView.reloadData()
    }
}
