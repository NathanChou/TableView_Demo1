//
//  ResultViewController.swift
//  FirstDemo
//
//  Created by 周彥宏 on 2017/3/13.
//  Copyright © 2017年 周彥宏. All rights reserved.
//

import UIKit

class ResultViewController: UITableViewController {
    
    
    var filterData = [String]();

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL1");
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


extension ResultViewController{
//    //MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return  filterData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL1", for: indexPath);
        cell.textLabel?.text = filterData[indexPath.row];
        
        return cell
    }
    
}

//採納UISearchResultsUpdating 實作func
extension ResultViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar;
        let searchText = searchBar.text!;
        let dataSource = DataSource();
        
        filterData = dataSource.filterName(searchText);
        tableView.reloadData();
    }
}












