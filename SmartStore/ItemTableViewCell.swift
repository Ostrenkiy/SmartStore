//
//  ItemTableViewCell.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemUidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithItem(item: Item) {
        itemNameLabel.text = item.name
        itemNumberLabel.text = "Количество: \(item.count)"
        itemPriceLabel.text = "\(item.price) руб."
        itemUidLabel.text = "UID: \(item.uid)"
    }
    
}
