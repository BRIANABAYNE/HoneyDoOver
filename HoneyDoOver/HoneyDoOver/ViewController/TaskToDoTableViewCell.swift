//
//  HoneyToDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit
// MARK: - Protocol 
protocol TaskToDoTableViewCellDelegate: AnyObject {
   
    func taskToDoSwitch(cell:TaskToDoTableViewCell)
}

class TaskToDoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskToDoButton: UIButton!
    @IBOutlet weak var taskToDoLabel: UILabel!
    
    // MARK: - Properties
    

    weak var delegate: TaskToDoTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func TaskToDoButtonTapped(_ sender: Any) {
        delegate?.taskToDoSwitch(cell: self)
    }

    // MARK: - Functions
    func updateUITask(task: Task) {
        taskToDoLabel.text =  task.taskName
        let image = task.isDone ?  "moon.fill" : "moon"
        taskToDoButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
}
