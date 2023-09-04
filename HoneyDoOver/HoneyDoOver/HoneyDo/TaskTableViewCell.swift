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
    

    // MARK: - Properties
    weak var delegate: TaskTableViewCellDelegate? // job opening - We make it weak to handle the memory, weak will not add to the memory. // No one has been hired yet, still need to assign the delegate.
    var toDoTask: TaskToDo?
    
    // MARK: - Property Observer
            {
        didSet { // calls code right after the property has changed 
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
        taskToDoLabel.text = task.taskToDoName
                                  // true - // false
        let image = task.isFinished ? "moon.fill" : "moon"
        taskToDoButton.setImage(UIImage(systemName: image), for: .normal)
    }
} // end of ViewCell
