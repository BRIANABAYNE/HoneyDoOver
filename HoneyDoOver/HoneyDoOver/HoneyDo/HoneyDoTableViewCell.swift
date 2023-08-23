//
//  HoneyDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

// MARK: - Protocol
protocol HoneyDoTableViewCellDelegate: AnyObject {
    func honeyDoToggle(cell: HoneyDoTableViewCell)
}


class HoneyDoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var honeyDoToggle: UISwitch!
    @IBOutlet weak var honeyDoTextField: UITextField!
    
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    // MARK: - Properties
    weak var delegate: HoneyDoTableViewCellDelegate? // job opening - We make it weak to handle the memory, weak will not add to the memory. // No one has been hired yet, still need to assign the delegate.
    var viewModel: HoneyDoViewModel!
    
    
    // MARK: - Actions
    @IBAction func honeyDoToggleSwitched(_ sender: Any) {
        delegate?.honeyDoToggle(cell: self) // the task that needs to be done by the employee 
    }
    
  // MARK: - Functions
    func updateUI(honeyDo:HoneyDo) {
        honeyDoToggle.isOn = honeyDo.isDone
        honeyDoTextField.text = honeyDo.honeyDo             // true - // false
//        let image = UIImage(systemName: honeyDo.isDone ? "" : "" )
//        honeyDoToggle.setImage(image, for: .normal)
    }
    

} // end of ViewCell
