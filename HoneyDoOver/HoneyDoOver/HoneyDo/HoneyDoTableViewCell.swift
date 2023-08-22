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
    @IBOutlet weak var honeyDoLabel: UILabel!
    
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Properties
    weak var delegate: HoneyDoTableViewCellDelegate?
    
    
    // MARK: - Actions
    @IBAction func honeyDoToggleSwitched(_ sender: Any) {
        delegate?.honeyDoToggle(cell: self)
        presentNewMessageAlert()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
  // MARK: - Functions
    func updateUI(honeyDo:HoneyDo) {
        honeyDoToggle.isOn =  honeyDo.isDone
        honeyDoLabel.text = honeyDo.honeyDo
    }
    

} // end of ViewCell
