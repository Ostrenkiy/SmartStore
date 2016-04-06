//
//  Item.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit
import SwiftyJSON

class Item: NSObject {
    var name: String
    var price: Int
    var count: Int
    var uid: Int
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.price = json["price"].intValue
        self.count = json["count"].intValue
        self.uid = json["uid"].intValue
        super.init()
    }
    
    init(name: String, price: Int, count: Int, uid: Int) {
        self.name = name
        self.price = price
        self.count = count
        self.uid = uid
        super.init()
    }
    
    func asDictionary() -> [String: AnyObject] {
        return [
            "name": name,
            "price": price,
            "count": count,
            "uid": uid
        ]
    }
}
