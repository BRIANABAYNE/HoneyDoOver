//
//  HoneyDoTableViewController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

class TaskTableViewController: UITableViewController {
// Adding the button here becasue it lives on the tableview no the cell.
    // MARK: - Outlets
    @IBOutlet weak var taskTextField: UITextField!
    
    // MARK: - Properties
   
    var taskToDo: TaskToDo?

    // MARK: - LifeCycles
    // viewDidLoad will only happen when the app launches
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HoneyDo" // title
    }
    
  //  I am adding view will appear + tableview reload data becasue the viewdid load only runs when the app launches and I need the tableview to reload our data once the user has created a task. This action happens when the app is still open meaning that viewDidLoad wont trigger again.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Actions
    
    @IBAction func taskButtonTapped(_ sender: Any) {
        guard let task = taskTextField.text, !task.isEmpty else { return }
        taskTextField.text = "" // will make the testfield empty again once the task has been added
        TaskController.shared.createTask(taskName: task)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.mormonTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        
        let chore = TaskController.shared.mormonTasks[indexPath.row]
        cell.toDoTask = chore
        cell.delegate = self // assigning the task Step 4 - Hiring the employee

        return cell
    }
    
    // Swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.mormonTasks[indexPath.row]
            TaskController.shared.deleteTask(doDelete: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "doTheseTaskBeezy",
              let destinationVC = segue.destination as? TaskToDoTableViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let dadTask = TaskController.shared.mormonTasks[indexPath.row]
        destinationVC.taskToDo = dadTask
    }
    
    func presentNewMessageAlert() {
        let alertController = UIAlertController(title: "All Done?" , message: "Would you like to delete this Task?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default)
        print("Action Taken: Dissmiss") // .default = blue // .destructive = red
        let yesAction = UIAlertAction(title: "Delete Task", style: .destructive) { _ in
            print("Action Taken: Delete List")
            // I tried to get this code working for the delete but it kept saying that task was nil. I didn't see why it wasn't working.
//            guard let task = self.taskToDo else {return }
//            TaskController.shared.deleteTask(doDelete: task)
            self.tableView.reloadData()
        }

            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true)
            
        }
    }
// end of VC

// MARK: - Extensions
//Extending the tableview controller, to the delegate. The employee doing the task that they were hired to do. Step 5
extension TaskTableViewController: TaskTableViewCellDelegate {
    func taskButtonTapped(cell: TaskTableViewCell) { // second place to hit in the data task for the protocol + delegate
     guard let indexPath = tableView.indexPath(for: cell) else { return }
        let task = TaskController.shared.mormonTasks[indexPath.row]
        TaskController.shared.toggleIsCompleted(taskToDo: task)
        cell.toDoTask = task
        presentNewMessageAlert()
        self.tableView.reloadData()
    }
}
