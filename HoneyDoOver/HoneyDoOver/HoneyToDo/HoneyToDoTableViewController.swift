//
//  HoneyToDoTableViewController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

class HoneyToDoTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var honeyToDoTextField: UITextField!
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HoneyTodDoViewModel()
    }
    
    // MARK: - Actions
    
    @IBAction func honeyToDoButtonTapped(_ sender: Any) {
        guard let honeyToDo = honeyToDoTextField.text else { return }
        viewModel.create(honeyToDo: honeyToDo)
        honeyToDoTextField.text = ""
        tableView.reloadData()
    }

    // MARK: - Properties
    
    var viewModel:HoneyTodDoViewModel!
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.completedHoneyToDo.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyToDo", for: indexPath) as?
        HoneyToDoTableViewCell else { return UITableViewCell() }
        
        
        let honeyToDo = viewModel.completedHoneyToDo[indexPath.row]
        cell.updateUI(honeyToDo: honeyToDo)
        cell.delegate = self
        return cell
    }

    // swip to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let honeyToDo = viewModel.completedHoneyToDo[indexPath.row]
            viewModel.delete(honeyToDo: honeyToDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    @objc func markAllFinished() {
        viewModel.markAllFinished()
        tableView.reloadData()
    }
    
    @objc func markAllNotFinished() {
        viewModel.markAllFinished()
        tableView.reloadData()
    }
    
    func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(markAllFinished), name: Constants.Notifications.markAllDone, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(markAllNotFinished), name: Constants.Notifications.markAllDone, object: nil)
        
    }
    
    func presentNextMessageAlert(honeytoDo: HoneyToDo) {
        
        let alertController = UIAlertController(title: "All Done?" , message: "What do you want to do?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Clear HoneyDo", style: .default) { _ in
            print("Action Taken: Dissmiss") // .default = blue
        }
        alertController.addAction(noAction) // .destructive = red
        let yesAction = UIAlertAction(title: "Delete HoneyDo", style: .destructive) { _ in
            print("Action Taken: Delete List")
//            cell.updateUI(honeyDo: honeyDo) // relfect what the cell should display now
            self.tableView.reloadData()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
//        self.viewModel.toggleIsFinished(honeyToDo: honeytoDo)
//        self.markAllNotFinished()     // will toggle
    }
    
} // end of VC

extension HoneyToDoTableViewController: HoneyToDoTableViewCellDelegate {
    func honeyToDoSwitch(cell: HoneyToDoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let honeyToDo = viewModel.honeyToDos[indexPath.row]
       viewModel.toggleIsFinished(honeyToDo: honeyToDo)
//        markAllFinished()
        presentNextMessageAlert(honeytoDo: honeyToDo)
       cell.updateUI(honeyToDo: honeyToDo)
        
        
    }
}
