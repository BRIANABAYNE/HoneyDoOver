//
//  HoneyToDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit
// MARK: - Protocol
protocol HoneyToDoTableViewCellDelegate: AnyObject {
    func honeyToDoSwitch(cell:HoneyToDoTableViewCell)
}

class HoneyToDoTableViewCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet weak var honeyToDoButton: UIButton!
    @IBOutlet weak var honeyToDoLabel1: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    // MARK: - Properties
    weak var delegate: HoneyToDoTableViewCellDelegate?
    

    // MARK: - Functions
    func updateUI(honeyToDo: TaskToDo) {
        honeyToDoLabel1.text = honeyToDo.honeyToDo
        let image = UIImage(systemName: honeyToDo.isFinished ? "moon.fill" : "moon")
        honeyToDoButton.setImage(image, for: .normal)
       
    }
    
    // MARK: - Actions
    
    @IBAction func honeyToDoButtonTapped(_ sender: Any) {
        delegate?.honeyToDoSwitch(cell: self)
    }
}
