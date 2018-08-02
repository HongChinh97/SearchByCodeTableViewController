//
//  TableViewController.swift
//  SearchByCodeTableViewController
//
//  Created by admin on 8/2/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating{
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    let data =  ["Cho", "Meo", "Khi", "Voi", "Ca Heo", "Ca Voi"]
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uy quyen cho TableViewController
        searchController.searchResultsUpdater = self
        //ngan thanh dieu hung an khi nhan tim kiem
        searchController.hidesNavigationBarDuringPresentation = false
        // cho biet ket qua tim kiem co bi mo di hay khong
        searchController.dimsBackgroundDuringPresentation = false
        //tao lap tableHeaderView la thanh tim kiem
        tableView.tableHeaderView = searchController.searchBar
        filteredData = data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredData = searchText.isEmpty ? (data) : (data.filter({ (data) -> Bool in
            return data.lowercased().contains(searchText.lowercased())
//            return data.range(of: searchText, options: .caseInsensitive) != nil
        }))
        tableView.reloadData()
    }
    
}

