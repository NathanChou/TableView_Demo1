//
//  ViewController.swift
//  FirstDemo
//
//  Created by 周彥宏 on 2017/3/13.
//  Copyright © 2017年 周彥宏. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    lazy var searcher:UISearchController = {
        let resultController = ResultViewController();
        let searchController = UISearchController(searchResultsController: resultController);
        searchController.searchResultsUpdater = resultController;
        return searchController;
    }();
    
    var dataSource:DataSource = DataSource();
    
    lazy var names:[String] = self.dataSource.names;
    
   
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController();
        configureEditing();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Custom function
    
    func configureSearchController(){
        let searchBar = searcher.searchBar;
        searchBar.sizeToFit();
        searchBar.placeholder = "Search here...";
        searcher.dimsBackgroundDuringPresentation = true;
        tableView.tableHeaderView = searchBar;
    }
    
    func configureEditing(){
        let editButtonItem = self.editButtonItem;
        editButtonItem.title = "編輯";
        self.navigationItem.setRightBarButtonItems([addBarButtonItem,editButtonItem], animated: true);
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: nil, action: nil);
    }
    
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true;
//    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated);
        
        if names.count == 0{
            editButtonItem.title = "編輯"
        }else{
            if editing == true{
                editButtonItem.title = "完成"
            }else{
                editButtonItem.title = "編輯"
            }

        }

    }

    
    //採納自訂的protocol 透過segue的identifier驗證 並指定代理人 拿到新增後放在segue的參考
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goAdd"{
            let addViewController = segue.destination as! AddViewController;
            addViewController.delegate = self;
        }
    }
    

}



extension ViewController{
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 ;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return names.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CELL0", for: indexPath) as! MyCell;
            cell.textField.text = names[indexPath.row];
            cell.textField.delegate = self; //UITextFieldDelegate需要指定代理人
            return cell;
        
        
    }
    
    //編輯模式下刪除
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            names.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .automatic);
            dataSource.names = names;
            editButtonItem.title = "編輯"
            tableView.setEditing(false, animated: true);
        }
    }
    
    //編輯模式下 移動
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let name = names[sourceIndexPath.row];
        names.remove(at: sourceIndexPath.row);
        names.insert(name, at: destinationIndexPath.row);
        dataSource.names = names;
    }
    
}

extension ViewController{
    //MARK: - UITableViewDelegate

    //左滑刪除
    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        let rowAction = UITableViewRowAction(style: .default, title: "刪除"){
            (rowAction1:UITableViewRowAction,indexPath:IndexPath) -> Void in
            self.tableView(tableView,commit: .delete,forRowAt: indexPath);
        }
        
        return [rowAction];
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}


//修改  採納UITextFieldDelegate 實作func
extension ViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField){
        print(textField.text!);
        let myCell = textField.superview?.superview as! MyCell;
        let indexPath = tableView.indexPath(for: myCell)!;
        names[indexPath.row] = textField.text!;
        dataSource.names = names;
        
    }
}

//新增  採納自訂的protocol 實作func
extension ViewController:AddViewControllerDelegate{
    func addNewName(_ name: String) {
        names.insert(name, at: 0);
        dataSource.names = names;
        tableView.reloadData();
    }
}








