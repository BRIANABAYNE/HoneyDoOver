//
//  HoneyDoTableViewController.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

class HoneyDoTableViewController: UITableViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var honeyDoTextField: UITextField!
    
    
    // MARK: - Properties
    
    var viewModel: HoneyDoViewModel!
//    var honeyDos:[HoneyDo]? // this needs to be on the VM
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HoneyDoViewModel()
        
    }
    // MARK: - Actions
    
    @IBAction func honeyDoButtonTapped(_ sender: Any) {
        // retriving the data
        guard let honeyDo = honeyDoTextField.text else  { return }
        viewModel.create(honeyDo: honeyDo)
        honeyDoTextField.text = ""
        tableView.reloadData() // this will call numberOfRows and then cellForRowAt
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.honeyDos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyCell", for: indexPath) as? HoneyDoTableViewCell
        else { return UITableViewCell() }
        
        let honeyDo = viewModel.honeyDos[indexPath.row]
        cell.updateUI(honeyDo: honeyDo)
        
        return cell
    }
    
    // Swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let honeyDo = viewModel.honeyDos[indexPath.row]
            viewModel.delete(honeyDo: honeyDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    // MARK: - Functions
    func update() {
        
//        honeyDoTextField.text = viewModel.honeyDo
        
    }
    
    @objc func markAllDone() {
        viewModel.markAllDone()
        tableView.reloadData()
    }
    
    @objc func markAllNotDone() {
        viewModel.markAllNotDone()
        tableView.reloadData()
    }
    
    func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(markAllDone), name: Constants.Notifications.markAllDone, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(markAllNotDone), name: Constants.Notifications.markAllDone, object: nil)
        
    }
    
    func presentNewMessageAlert() {
        let alertController = UIAlertController(title: "All Done?" , message: "Would you like to delete this Honey-Do?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default) { _ in
            print("Action Taken: Dissmiss") // .default = blue
        }
        alertController.addAction(noAction) // .destructive = red
        let yesAction = UIAlertAction(title: "Delete List", style: .destructive) { _ in
            print("Action Taken: Delete List")
            /// Finish this
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
        
    }
    
} // end of VC

// MARK: - Extensions -Extending the tableview controller, do the delegate. The employee doing the task that they were hired to do.
extension HoneyDoTableViewController: HoneyDoTableViewCellDelegate {
    func honeyDoToggle(cell: HoneyDoTableViewCell) { // second place to hit in the data task for the protocol + delegate
       guard let indexPath = tableView.indexPath(for: cell) else { return }
        let honeyDo = viewModel.honeyDos[indexPath.row]
        viewModel.toggleIsDone(honeyDo: honeyDo)
        cell.updateUI(honeyDo: honeyDo)
    }
    
}
