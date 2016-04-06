//
//  Cart.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit
import SwiftyJSON

class Cart: NSObject {
    var date: NSTimeInterval
    var payment: String
    var items: [Int]
    var totalPrice: Int
    
    init(json: JSON) {
        self.date = json["date"].doubleValue
        self.payment = json["payment"].stringValue
        self.items = json["items"].arrayObject as! [Int]
        self.totalPrice = json["total_price"].intValue
        super.init()
    }
}
