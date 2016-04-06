//
//  CartTableViewCell.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithCart(cart: Cart) {
        let d = NSDate(timeIntervalSince1970: cart.date).getFormatString()
        dateLabel.text = "\(d)"
        priceLabel.text = "\(cart.totalPrice) руб"
    }
    
}

extension NSDate {
    func getFormatString() -> String {
        let formatter = NSDateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        formatter.timeZone = .None
        return formatter.stringFromDate(self)
    }
}