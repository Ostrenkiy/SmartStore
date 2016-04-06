//
//  APIMethods.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIMethods {
    static let url = "http://smartstoreserver.eu-gb.mybluemix.net"
    
    static func getItems(success: [Item]-> Void, error errorHandler:String->Void) {
        Alamofire.request(.GET, "\(url)/api/items").responseSwiftyJSON({
            _, _, json, error in
            if let e = error {
                errorHandler((e as NSError).localizedDescription)
                return
            }
            var items : [Item] = []
            for itemJson in json["items"].arrayValue {
                items += [Item(json: itemJson)]
            }
            print(items)
            success(items)
            return
        })
    }
    
    static func getCarts(success: [Cart]-> Void, error errorHandler:String->Void) {
        Alamofire.request(.GET, "\(url)/api/carts").responseSwiftyJSON({
            _, _, json, error in
            if let e = error {
                errorHandler((e as NSError).localizedDescription)
                return
            }
            var carts : [Cart] = []
            for cartJson in json["carts"].arrayValue {
                carts += [Cart(json: cartJson)]
            }
            success(carts)
            return
        })
    }
    
    static func postItem(item: Item, success:Void->Void, error errorHandler:String->Void) {
        Alamofire.request(.POST, "\(url)/api/items", parameters: item.asDictionary(), encoding: .JSON, headers: nil).responseSwiftyJSON({
            _, _, json, error in
            if let e = error {
                errorHandler((e as NSError).localizedDescription)
                return
            }
            if json["status"].stringValue == "error" {
                errorHandler(json["message"].stringValue)
                return
            }
            if json["status"].stringValue == "success" {
                success()
                return
            }
        })
    }
    
    static func getManyItems(items: [Int], success: [(Int, Item)]->Void, error errorHandler: String->Void) {
        var idCount = [Int: Int]()
        for itemId in items {
            if let count = idCount[itemId] {
                idCount[itemId] = count + 1
            } else {
                idCount[itemId] = 0
            }
        }
        
        getItems({
            items in
            var res : [(Int, Item)] = []
            for (itemId, itemCount) in idCount {
                if let index = items.indexOf({$0.uid == itemId}) {
                    res += [(itemCount, items[index])]
                }
            } 
        }, error: {
            errormsg in
                
        })

        
    }
    
}

func performUI(block: Void->Void) {
    dispatch_async(dispatch_get_main_queue(), {
        block()
    })
}
