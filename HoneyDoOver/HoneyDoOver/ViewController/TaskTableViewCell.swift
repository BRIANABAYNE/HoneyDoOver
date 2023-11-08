//
//  HoneyDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

// MARK: - Protocol

protocol TaskTableViewCellDelegate: AnyObject {
    
    func taskButtonTapped(cell: TaskTableViewCell)
    
}
class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskToDoButton: UIButton!
    @IBOutlet weak var taskToDoLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    // MARK: - Properties
    weak var delegate: TaskTableViewCellDelegate?
    
    // MARK: - Property Observer
                var toDoTask: TaskToDo? {
        didSet {
        updateUIFirstScreen()
        }
    }
    
    // MARK: - Actions
    @IBAction func taskToDoButtonTapped(_ sender: Any) {
        delegate?.taskButtonTapped(cell: self)
    }
    
  // MARK: - Functions
    func updateUIFirstScreen() {
    
        guard let task = toDoTask else { return }
        countLabel.text = "\(task.taskToDos.count)"
        taskToDoLabel.text = task.taskToDoName
        let image = task.isFinished ? "moon.fill" : "moon"
        taskToDoButton.setImage(UIImage(systemName: image), for: .normal)
    }
} 
