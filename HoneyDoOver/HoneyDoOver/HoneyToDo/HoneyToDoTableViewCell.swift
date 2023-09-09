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
    
    @IBOutlet weak var honeyToDoToggle: UISwitch!
    @IBOutlet weak var honeyToDoLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Properties
    weak var delegate: HoneyToDoTableViewCellDelegate?
    

    // MARK: - Functions
    func updateUI(honeyToDo: HoneyToDo) {
        honeyToDoToggle.isOn = honeyToDo.isFinished
        honeyToDoLabel.text = honeyToDo.honeyToDo
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func honeyToDoToggleSwitched(_ sender: Any) {
        delegate?.honeyToDoSwitch(cell: self)
    }


}
