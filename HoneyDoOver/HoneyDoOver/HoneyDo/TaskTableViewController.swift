//
//  HoneyDoTableViewController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
 
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskTextField: UITextField!
    
    
    // MARK: - Properties
    
    var taskToDo: TaskToDo?

    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "HoneyDo" // title
      notificationCenter()
    }
    // MARK: - Actions
    
    @IBAction func taskButtonTapped(_ sender: Any) {
        // retriving the data
        guard let task = taskTextField.text else  { return }
        taskTextField.text = ""
        tableView.reloadData() // this will call numberOfRows and then cellForRowAt
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskToDo?.taskToDos.count ?? 0
       // Value of optional type 'Int?' must be unwrapped to a value of type 'Int'
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyCell", for: indexPath) as? TaskTableViewCell,
                let chore = taskToDo?.taskToDos[indexPath.row] else {return UITableViewCell()}
             cell.updateUI(task: chore)
        cell.delegate = self // assigning the task
        return cell
    }
    
    // Swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           guard let task = taskToDo?.taskToDos[indexPath.row],
            let taskToDo = self.taskToDo else { return }
            TaskController().deleteCompeletedTask(task: task, toDoTasks: taskToDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

////
//    @objc func markAllDone() {
//        viewModel.markAllDone()
//        tableView.reloadData()
//    }
//
//    @objc func markAllNotDone() {
//        viewModel.markAllNotDone()
//        tableView.reloadData()
//    }
//
//    func notificationCenter() {
//        NotificationCenter.default.addObserver(self, selector: #selector(markAllDone), name: Constants.Notifications.markAllDone, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(markAllNotDone), name: Constants.Notifications.markAllDone, object: nil)
//
//    }
//
    func presentNewMessageAlert(honeyDo: Task) {
        let alertController = UIAlertController(title: "All Done?" , message: "Would you like to delete this Honey-Do?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default) { _ in
            print("Action Taken: Dissmiss") // .default = blue
        }
        alertController.addAction(noAction) // .destructive = red
        let yesAction = UIAlertAction(title: "Delete HoneyDo", style: .destructive) { _ in
            print("Action Taken: Delete List")
//         self.viewModel.toggleIsDone(honeyDo: honeyDo) // will toggle
//           cell.updateUI(honeyDo: honeyDo) // relfect what the cell should display now
            self.tableView.reloadData()
            
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
        
    }
    
} // end of VC

// MARK: - Extensions -Extending the tableview controller, do the delegate. The employee doing the task that they were hired to do.
extension TaskTableViewController: TaskTableViewCellDelegate {
    func taskButtonTapped(cell: TaskTableViewCell) { // second place to hit in the data task for the protocol + delegate
     guard let indexPath = tableView.indexPath(for: cell) else { return }
        let task = TaskController.shared.mormonTask[indexPath.row]
        TaskController.shared.toggleTaskToFinish(for: task)
        cell.taskToDo = task
      presentNewMessageAlert(honeyDo: Task)
    
    }
    
}
