//
//  TableViewController.swift
//  SearchByCodeTableViewController
//
//  Created by admin on 8/2/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    var heroArray = [Hero]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredData = [Hero]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uy quyen cho TableViewController
        searchController.searchResultsUpdater = self
        
        //ngan thanh dieu hung an khi nhan tim kiem
        searchController.hidesNavigationBarDuringPresentation = false
        
        // cho biet ket qua tim kiem co bi mo di hay khong
        searchController.dimsBackgroundDuringPresentation = false
        
        //tao lap tableHeaderView la thanh tim kiem
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        loadSample()
        filteredData = heroArray
        
    }
    
    private func loadSample() {
        let hero1 = Hero(name: "DrowRanger", category: "agility", image: #imageLiteral(resourceName: "DrowRanger"))
        
        let hero2 = Hero(name: "Mirana", category: "agility", image: #imageLiteral(resourceName: "Mirana"))
        
        let hero3 = Hero(name: "PhantomAssassin", category: "agility", image: #imageLiteral(resourceName: "PhantomAssassin"))
        
        let hero4 = Hero(name: "TemplarAssassin", category: "agility", image: #imageLiteral(resourceName: "TemplarAssassin"))
        
        let hero5 = Hero(name: "VengefulSpirit", category: "agility", image: #imageLiteral(resourceName: "VengefulSpirit"))
        
        let hero6 = Hero(name: "Abaddon", category: "strength", image: #imageLiteral(resourceName: "Abaddon"))
        
        let hero7 = Hero(name: "EarthShaker", category:"strength", image: #imageLiteral(resourceName: "EarthShaker"))
        
        let hero8 = Hero(name: "Huskar", category: "strength", image: #imageLiteral(resourceName: "Huskar"))
        
        let hero9 = Hero(name: "Phoenix", category: "strength", image: #imageLiteral(resourceName: "Phoenix"))
        
        let hero10 = Hero(name: "Tusk", category: "strength", image: #imageLiteral(resourceName: "Tusk"))
        
        heroArray += [hero1, hero2, hero3, hero4, hero5, hero6, hero7, hero8, hero9, hero10]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = filteredData[indexPath.row].name
        cell.categoryLabel.text = filteredData[indexPath.row].category
        cell.myImage.image = filteredData[indexPath.row].image
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        // dua het cac ki tu ve dang chu thuong
        filteredData = searchText.isEmpty ? (heroArray) : (heroArray.filter({ (heroArray: Hero) -> Bool in
            return heroArray.name.lowercased().contains(searchText.lowercased())
        }))
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let index = heroArray.index(of: filteredData[indexPath.row]) {
                    detailViewController.dataObject = heroArray[index]
                }
            }
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if let newTableView = unwindSegue.source as? DetailViewController {
            if let textIndex = tableView.indexPathForSelectedRow {
                if let index = heroArray.index(of: filteredData[textIndex.row]) {
                    heroArray[index] = newTableView.dataObject!
                    filteredData = heroArray
                }
            }
            else {
                heroArray.append(newTableView.dataObject!)
                filteredData = heroArray
            }
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if let index = heroArray.index(of: filteredData[indexPath.row]) {
                 heroArray.remove(at: index)
            }
            filteredData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            print("Delete")
        }
    }
    
    
}

