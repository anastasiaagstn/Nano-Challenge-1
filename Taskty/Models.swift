//
//  Models.swift
//  Taskty
//
//  Created by Anastasia Agustine on 28/04/22.
//

import Foundation

struct TaskItem {
    var name: String
    var date: String?
    var priority: Int
    var notes: String?
}


struct taskFeeder {
    func feeder() -> [TaskItem]{
        return [
            TaskItem(name: "Clean the house", date: "31 Dec 2021", priority: 1, notes: ""),
            TaskItem(name: "Take dog to the vet", date: "31 Dec 2021", priority: 2, notes: "coco been looking ill since yesterday"),
            TaskItem(name: "Take out the trash", date: "28 Dec 2021", priority: 1, notes: ""),
            TaskItem(name: "Finish summary essay", date: "28 Dec 2021", priority: 2, notes: "The summary essay for history class, bookmark: chapter 10"),
            TaskItem(name: "Go to car wash", date: "29 Dec 2021", priority: 0, notes: "")
        ]
    }
}
