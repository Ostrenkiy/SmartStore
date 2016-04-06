//
//  AllCartsViewController.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit

class AllCartsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl : UIRefreshControl? = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()

        tableView.registerNib(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        tableView.registerNib(UINib(nibName: "CartItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CartItemTableViewCell")

        refreshControl?.addTarget(self, action: #selector(AllCartsViewController.refreshCarts), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl ?? UIView())
        refreshControl?.beginRefreshing()
        refreshCarts()
        
        // Do any additional setup after loading the view.
    }
    
    func refreshCarts() {
        APIMethods.getCarts({ 
            Carts in
            self.Carts = Carts.sort({
                cart1, cart2 in
                return cart1.date > cart2.date
            })
            performUI{
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
            APIMethods.getItems({ 
                items in
                self.getItemsForCarts(items)
                performUI{
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }, error: {
                errormsg in
                print(errormsg)
            })
            
        }, error: {
            errormsg in
            print(errormsg)
            performUI{
                self.refreshControl?.endRefreshing()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var Carts : [Cart] = []
    var allItems = [Cart: [(Int, Item?)]]()
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func getItemsForCarts(items: [Item]){
        for cart in Carts {
            
            var idCount = [Int: Int]()
            for itemId in cart.items {
                if let count = idCount[itemId] {
                    idCount[itemId] = count + 1
                } else {
                    idCount[itemId] = 1
                }
            }
            
            var res : [(Int, Item?)] = []
            for (itemId, itemCount) in idCount {
                if let index = items.indexOf({$0.uid == itemId}) {
                    let i : Item? = items[index]
                    res += [(itemCount, i)]
                } else {
                    res += [(itemCount, nil)]
                }
            } 
            
            allItems[cart] = res
        }
    }
    
}

extension AllCartsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension AllCartsViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Carts.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cartItems = allItems[Carts[section]] {
            return cartItems.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartTableViewCell") as! CartTableViewCell
        cell.initWithCart(Carts[section])
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartItemTableViewCell", forIndexPath: indexPath) as! CartItemTableViewCell
        let itemsArr = allItems[Carts[indexPath.section]]!
        let itemInfo = itemsArr[indexPath.row]
        
        cell.initWithCartItem(itemInfo.1, count: itemInfo.0)
        
        return cell
    }
}