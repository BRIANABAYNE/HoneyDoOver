//
//  HoneyToDoTableViewController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

class TaskToDoTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var taskToDoTextField: UITextField!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Properties
    var taskToDo: TaskToDo?

    // MARK: - Actions

    @IBAction func taskToDoButtonTapped(_ sender: Any) {
        guard  let task = taskToDoTextField.text,
          let toDoTask = self.taskToDo else { return }
        taskToDoTextField.text = ""
          TaskController().createTaskToComplete(toComplete: toDoTask, taskItem: task)
        self.tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskToDo?.taskToDos.count ?? 0
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyToDo", for: indexPath) as?
        TaskToDoTableViewCell,
        let task = taskToDo?.taskToDos[indexPath.row] else { return UITableViewCell()}
       
        cell.updateUITask(task: task)
      
        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           guard let taskToDo = taskToDo?.taskToDos[indexPath.row],
                let mormonTask = self.taskToDo else { return }
            TaskController().deleteCompeletedTask(task: taskToDo, toDoTasks: mormonTask)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }

    func presentAlertWhenAllFinished() {
        
        let alertController = UIAlertController(title: "All Done?" , message: "What do you want to do?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Keep Task", style: .default)
            print("Action Taken: Dissmiss")
        let yesAction = UIAlertAction(title: "Delete Task", style: .destructive) { _ in
            print("Action Taken: Delete List")
            guard let dadTaskToDo = self.taskToDo else { return }
            TaskController.shared.deleteTask(doDelete: dadTaskToDo)
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
    }
    
    func allTaskDone() {
       
        guard let toDoTask = taskToDo else { return }

        for task in toDoTask.taskToDos {

            if task.isDone == false {
                return
            }
        }
        presentAlertWhenAllFinished()
    }
    
} // end of VC

// MARK: - Extension

extension TaskToDoTableViewController: TaskToDoTableViewCellDelegate {
    func taskToDoSwitch(cell: TaskToDoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
        let taskToDo = self.taskToDo else { return }
      let task = taskToDo.taskToDos[indexPath.row]
        TaskController().toggleTaskToFinish(for: task)
        allTaskDone()
        self.tableView.reloadData() 
    }
}
