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
       

      notificationCenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    // MARK: - Actions
    // Button tapped
    @IBAction func honeyToDoButtonTapped(_ sender: Any) {
        guard let honeyToDo = taskToDoTextField.text else { return } // guarding this, if we cant
        viewModel.createTask(for: honeyToDo, task: taskToDo)
        taskToDoTextField.text = ""
        tableView.reloadData()
    }

    // MARK: - Properties
    
    var viewModel:HoneyToViewController!
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.honeyToDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyToDo", for: indexPath) as?
        HoneyToDoTableViewCell else { return UITableViewCell() }
        
        
        let honeyToDo = viewModel.honeyToDos[indexPath.row]
        cell.updateUI(honeyToDo: honeyToDo)
        cell.delegate = self
        return cell
    }

    // swip to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let honeyToDo = viewModel.honeyToDos[indexPath.row]
            viewModel.delete(honeyToDo: honeyToDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    @objc func markAllFinished() {
        viewModel.markAllFinished()
        tableView.reloadData()
    }
    
    @objc func markAllNotFinished() {
        viewModel.markAllNotFinished()
        tableView.reloadData()
    }
    
    func notificationCenter() {
      NotificationCenter.default.addObserver(self, selector: #selector(markAllFinished), name: Constants.Notifications.markAllDone, object: nil)
     NotificationCenter.default.addObserver(self, selector: #selector(markAllNotFinished), name: Constants.Notifications.markALLNotDone, object: nil)
        
    }
    
    func presentNextMessageAlert(honeyToDo: TaskToDo) {
        
        let alertController = UIAlertController(title: "All Done?" , message: "What do you want to do?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Keep HoneyDo", style: .default) { _ in
            print("Action Taken: Dissmiss") // .default = blue
        }
        alertController.addAction(noAction) // .destructive = red
        let yesAction = UIAlertAction(title: "Delete HoneyDo", style: .destructive) { _ in
            print("Action Taken: Delete List")
            self.viewModel.toggleIsFinished(honeyToDo: honeyToDo)
            
//            cell.updateUI(honeyDo: honeyDo) // relfect what the cell should display now
            self.tableView.reloadData()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
//      self.markAllNotFinished()     // will toggle
    }
    
} // end of VC

extension TaskToDoTableViewController: HoneyToDoTableViewCellDelegate {
    func honeyToDoSwitch(cell: HoneyToDoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let honeyToDo = viewModel.honeyToDos[indexPath.row]
      self.viewModel.toggleIsFinished(honeyToDo: honeyToDo)
//        self.viewModel.markAllFinished()
        cell.updateUI(honeyToDo: honeyToDo)
        
      for honeyToDo in viewModel.honeyToDos {
         if honeyToDo.isFinished != true {
             return
          }
        }
//        viewModel.honeyToDos.isFinished = true
       presentNextMessageAlert(honeyToDo: honeyToDo )
        
//      markAllFinished()
            
        }
        
    }
