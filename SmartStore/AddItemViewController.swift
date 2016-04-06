//
//  AddItemViewController.swift
//  SmartStore
//
//  Created by Alexander Karpov on 25.03.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var uidTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var addItem: UIBarButtonItem!
    
    
    var item : Item?
    
    func constructItem() -> Item? {
        if let name = nameTextField.text,
            let uid = Int(uidTextField.text ?? ""),
            let price = Int(priceTextField.text ?? ""),
            let count = Int(countTextField.text ?? "") {
            
            return Item(name: name, price: price, count: count, uid: uid)
        } else {
            showError()
            return nil
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ошибка", message: "Неверный формат данных", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func topItemPressed(sender: UIBarButtonItem) {
        if let i = constructItem() {
            addItem(i)
        }
    }
    
    func initWithItem(item: Item) {
        nameTextField.text = item.name
        uidTextField.text = "\(item.uid)"
        priceTextField.text = "\(item.price)"
        countTextField.text = "\(item.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let i = item {
            initWithItem(i)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(item: Item) {
        APIMethods.postItem(item, success: {
            self.itemAddedHandler()
            }, error: {
                errormsg in 
                print(errormsg)
        })
    }
    
    func itemAddedHandler() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
