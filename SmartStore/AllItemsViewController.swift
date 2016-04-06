//
//  AllItemsViewController.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit

class AllItemsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl : UIRefreshControl? = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        tableView.registerNib(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        refreshControl?.addTarget(self, action: #selector(AllItemsViewController.refreshItems), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl ?? UIView())
        refreshControl?.beginRefreshing()
        refreshItems()

        // Do any additional setup after loading the view.
    }
    
    func refreshItems() {
        APIMethods.getItems({ 
            items in
                self.items = items
                performUI{
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
                
            }, error: {
                errormsg in
                print(errormsg)
                performUI{
                    self.refreshControl?.endRefreshing()
                }
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var items : [Item] = []

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pushAddController" {
            let dvc = segue.destinationViewController as! AddItemViewController
            let i = sender as? Item
            dvc.item = i
        }
    }

}

extension AllItemsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("pushAddController", sender: items[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

extension AllItemsViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemTableViewCell", forIndexPath: indexPath) as! ItemTableViewCell
        
        cell.initWithItem(items[indexPath.row])
        
        return cell
    }
}