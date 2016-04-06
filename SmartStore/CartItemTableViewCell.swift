//
//  CartItemTableViewCell.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithCartItem(item: Item?, count: Int) {
        countLabel.text = "\(count)"
        if let i = item { 
            nameLabel.text = "\(i.name)"
        } else {
            nameLabel.text = "Unknown item with some UID"
        }
    }
}
