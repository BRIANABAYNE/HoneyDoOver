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
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    // MARK: - Properties
    weak var delegate: TaskTableViewCellDelegate? // job opening - We make it weak to handle the memory, weak will not add to the memory. // No one has been hired yet, still need to assign the delegate.
 
    
    
    // MARK: - Actions
    @IBAction func taskToDoButtonTapped(_ sender: Any) {
        delegate?.taskButtonTapped(cell: self)
    }
    
  // MARK: - Functions
    func updateUI(task: Task) {
        taskToDoLabel.text = task.taskName             // true - // false
       let image = UIImage(systemName: task.isDone ? "moon.fill" : "moon" )
       taskToDoButton.setImage(image, for: .normal)
    }
    

} // end of ViewCell
