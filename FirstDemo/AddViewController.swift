//
//  AddViewController.swift
//  FirstDemo
//
//  Created by 周彥宏 on 2017/3/14.
//  Copyright © 2017年 周彥宏. All rights reserved.
//

import UIKit

//自訂的protocol 方法為新增字串
protocol AddViewControllerDelegate:class {
    func addNewName(_ name:String);
}

class AddViewController: UITableViewController {
    
    
    @IBOutlet weak var addField: UITextField!
    
    //指定代理人
    weak var delegate:AddViewControllerDelegate?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func userAdd(_ sender: UIButton) {
        
        //不管成功失敗都會跳回viewController
        defer{
            self.navigationController?.popViewController(animated: true);
        }
        if addField.text!.isEmpty == true{
            return;
        }
        //適當的時間使用func 把資料一起帶到segue
        delegate?.addNewName(addField.text!);
    }

   
    
}
