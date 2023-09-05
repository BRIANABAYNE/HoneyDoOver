//
//  HoneyDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

// MARK: - Protocol
// Always about the class and under the import
protocol TaskTableViewCellDelegate: AnyObject { // Telling the protocol what it's going to confirm to = Anyobject - this protocol is the manager with a list of task that need to be done. Step 1
    func taskButtonTapped(cell: TaskTableViewCell) // Task that we want to happen, want a toggle to change states - the parms needs to know what the task was tapped. There is no body to this function becasue protocols methods must not have bodies.
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var taskToDoButton: UIButton!
    @IBOutlet weak var taskToDoLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: TaskTableViewCellDelegate? // job opening - We make it weak to handle the memory, weak will not add to the memory. // No one has been hired yet, still need to assign the delegate. step 2
    
    // MARK: - Property Observer
                var toDoTask: TaskToDo? {
        didSet {  // whenever I assign a property to toDoTask: TaskToDo, updateUIFristScreen will run
        updateUIFirstScreen()
        }
    }
    
    // MARK: - Actions
    @IBAction func taskToDoButtonTapped(_ sender: Any) {
        delegate?.taskButtonTapped(cell: self) // step 3 - calling the delegate
        
    }
    
  // MARK: - Functions
    
  
    func updateUIFirstScreen() {
        
        // Making sure I have a task
        guard let task = toDoTask else { return }
        countLabel.text = "\(task.taskToDos.count)"
        // the lable. text is assigned task. taskToDoName - taskToDoName is my model object 
        taskToDoLabel.text = task.taskToDoName
                                  // true - // false
        let image = task.isFinished ? "moon.fill" : "moon"
        taskToDoButton.setImage(UIImage(systemName: image), for: .normal)
    }
} // end of ViewCell
