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
        
        title = "HoneyDo"
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Actions
    
    @IBAction func taskButtonTapped(_ sender: Any) {
      
        guard let task = taskTextField.text else { return }
        taskTextField.text = ""
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
        cell.delegate = self

        return cell
    }
    

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
    
    func presentNewMessageAlert(task: TaskToDo) {
        let alertController = UIAlertController(title: "All Done?" , message: "Would you like to delete this Task?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default)
        print("Action Taken: Dissmiss")
        let yesAction = UIAlertAction(title: "Delete Task", style: .destructive) { _ in
            print("Action Taken: Delete List")
            
            guard let task = self.taskToDo else {return }
            TaskController.shared.deleteTask(doDelete: task)
            self.tableView.reloadData()
        }
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true)
        }
    }

// MARK: - Extensions

extension TaskTableViewController: TaskTableViewCellDelegate {
    func taskButtonTapped(cell: TaskTableViewCell) {
     guard let indexPath = tableView.indexPath(for: cell) else { return }
        let task = TaskController.shared.mormonTasks[indexPath.row]
        TaskController.shared.toggleIsCompleted(taskToDo: task)
        cell.toDoTask = task
        presentNewMessageAlert(task: task)
        self.tableView.reloadData()
    }
}
