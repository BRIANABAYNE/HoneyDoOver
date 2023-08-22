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
    

    // MARK: - Properties
    
    var viewModel:HoneyTodDoViewModel!
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.honeyToDos.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "honeyToDo", for: indexPath) as?
        HoneyToDoTableViewCell else { return UITableViewCell() }
        
        
        let honeyToDo = viewModel.honeyToDos[indexPath.row]
        cell.updateUI(honeyToDo: honeyToDo)
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let honeyToDo = viewModel.honeyToDos[indexPath.row]
            viewModel.delete(honeyToDo: honeyToDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        
        
    }
}
