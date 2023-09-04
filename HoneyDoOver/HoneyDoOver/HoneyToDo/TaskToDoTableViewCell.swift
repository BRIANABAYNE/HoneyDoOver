//
//  HoneyToDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit
// MARK: - Protocol - Always above the class and under the import
protocol TaskToDoTableViewCellDelegate: AnyObject { // Telling the protocol what it's going to confirm to = AnyObject - This protocal is the manager with a list of task that need to be done. Step 1
    func taskToDoSwitch(cell:TaskToDoTableViewCell) // task that we want to happen, want a toggle to change states - the perimter needs to know what task was tapped. There is no body on this function becasue Protocol methods must not have bodies.
}

class TaskToDoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskToDoButton: UIButton!
    @IBOutlet weak var taskToDoLabel: UILabel!
    
    // MARK: - Properties
    
    // Step 2 - delegate a task - job opening - making it weak so it doesn't add to the memory
    weak var delegate: TaskToDoTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func TaskToDoButtonTapped(_ sender: Any) {
        delegate?.taskToDoSwitch(cell: self) // self is TaskToDoTableViewCell / calling the delegate - Step 3
    }

    // MARK: - Functions
    func updateUITask(task: Task) {
        taskToDoLabel.text =  task.taskName
        let image = task.isDone ?  "moon.fill" : "moon"
        taskToDoButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
}
