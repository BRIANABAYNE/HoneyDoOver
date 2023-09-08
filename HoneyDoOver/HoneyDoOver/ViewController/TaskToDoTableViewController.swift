//
//  HoneyToDoTableViewController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

class TaskToDoTableViewController: UITableViewController {
    
    // Adding the outlet of the textField here since it lives on the tableView and not the cell.
    // MARK: - Outlets
    @IBOutlet weak var taskToDoTextField: UITextField!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Properties
    
    var taskToDo: TaskToDo?

    // MARK: - Actions
    // Button tapped
    @IBAction func taskToDoButtonTapped(_ sender: Any) {
        // guarding that task will be assigned taskToDoText. text creating a constant to be assigned self. taskToDo and plugging them bot into my createTask function
        guard  let task = taskToDoTextField.text,
          let toDoTask = self.taskToDo else { return }
        taskToDoTextField.text = "" // Once a user puts in a task, the textField will go back to empty
          TaskController().createTaskToComplete(toComplete: toDoTask, taskItem: task)
        // calling reload tableview becasue If I don't, nothing will happen once a user creates a task. The screen will remian blank.
        self.tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskToDo?.taskToDos.count ?? 0 // nil coalescing
      // return tasktoDo ( my porperty oh this page) .tasktoDo that has the value of an array of Task. count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyToDo", for: indexPath) as?
        TaskToDoTableViewCell, // asking to return my custom cell or else return a basic B 
        let task = taskToDo?.taskToDos[indexPath.row] else { return UITableViewCell()}
       
        cell.updateUITask(task: task)
        // Hiring the employee - accessing the delegate property. Self = TaskToDoTableViewController - Step 4
        cell.delegate = self
        return cell
    }

    // swip to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           guard let taskToDo = taskToDo?.taskToDos[indexPath.row],
                let mormonTask = self.taskToDo else { return }
            // Calling TaskController() becasue Instance member 'Delete' cannot be used on type TaskController, I need to use the value of this type instead.
            TaskController().deleteCompeletedTask(task: taskToDo, toDoTasks: mormonTask)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }

    func presentAlertWhenAllFinished() {
        
        let alertController = UIAlertController(title: "All Done?" , message: "What do you want to do?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Keep Task", style: .default)
            print("Action Taken: Dissmiss") // .default = blue,   // .destructive = red
        let yesAction = UIAlertAction(title: "Delete Task", style: .destructive) { _ in
            print("Action Taken: Delete List")
            guard let dadTaskToDo = self.taskToDo else { return } // guarding that dadTaskToDo will be assigned to self(TaskToDoTableViewCotroller) . my property .tasktoDo else do nothing
            TaskController.shared.deleteTask(doDelete: dadTaskToDo) // calling taskcontroller.shared instance and my delete crud function that I create and deleting and plugging in the constatnt.
            self.navigationController?.popViewController(animated: true)// will pop the view like a pancake
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
    }
    // function for when all toggle has been tapped
    func allTaskDone() {
        // creating a constant that is being assigned the value of taskToDo - the property on taskTableViewContoller // If that's not true then return
        guard let toDoTask = taskToDo else { return }
        // 4 loop - adding .taskToDos from my mode TaskToDo that has the value of an array of taks
        for task in toDoTask.taskToDos {
            // if task is done = is done is connected to my toggle that's a boolean propery is == to false then return
            if task.isDone == false {
                return
            }
        } // IF all toggled is finished, the alert will present
        presentAlertWhenAllFinished()
    }
    
} // end of VC

// MARK: - Extension
// Confirming to TaskToDoTableViewCellDelegate - Step 5 
extension TaskToDoTableViewController: TaskToDoTableViewCellDelegate {
    func taskToDoSwitch(cell: TaskToDoTableViewCell) { // what I created on the cell - how to do the tasks
        guard let indexPath = tableView.indexPath(for: cell),
        let taskToDo = self.taskToDo else { return } // constatn assigning the value to self that is this file .taskToDo from my property
      let task = taskToDo.taskToDos[indexPath.row]
        TaskController().toggleTaskToFinish(for: task)
        allTaskDone() // calling the for in lopp
        self.tableView.reloadData() // need to reload the tableview since there will be a change if we delete the task
    }
}
