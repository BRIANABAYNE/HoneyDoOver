//
//  HoneyDoTableViewCell.swift
//  HoneyDoOver
//
//  Created by Briana Bayne on 8/19/23.
//

import UIKit

// MARK: - Protocol
protocol HoneyDoTableViewCellDelegate: AnyObject {
    func honeyDoButtonTapped(cell: HoneyDoTableViewCell)
}


class HoneyDoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var honeyDoButton: UIButton!
    @IBOutlet weak var honeyDoLabel: UILabel!
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    // MARK: - Properties
    weak var delegate: HoneyDoTableViewCellDelegate? // job opening - We make it weak to handle the memory, weak will not add to the memory. // No one has been hired yet, still need to assign the delegate.
    var viewModel: HoneyDoViewModel!
    
    
    // MARK: - Actions
    @IBAction func honeyDoButtonTapped(_ sender: Any) {
        delegate?.honeyDoButtonTapped(cell: self)
    }
    
  // MARK: - Functions
    func updateUI(honeyDo: Task) {
        honeyDoLabel.text = honeyDo.taskName             // true - // false
       let image = UIImage(systemName: honeyDo.isDone ? "moon.fill" : "moon" )
       honeyDoButton.setImage(image, for: .normal)
    }
    

} // end of ViewCell
