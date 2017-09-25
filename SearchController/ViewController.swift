//
//  ViewController.swift
//  SearchController
//
//  Created by Ahmed Khedr on 1/5/16.
//  Copyright © 2016 Ahmed Khedr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var searchController: UISearchController!
    
    private var products = [ "iPhone", "iPad", "iMac", "Apple Watch", "iPod Touch", "MacBook Air", "MacBook Pro", "Mac TV" ]
    private var filteredProducts = [String]()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        initializeSearchController()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchController.isActive {
            
        case true:
            return filteredProducts.count
            
        case false:
            return products.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch searchController.isActive {

        case true:
            cell.textLabel?.text = filteredProducts[indexPath.row]

        case false:
            cell.textLabel?.text = products[indexPath.row]
        }

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let secondController = segue.destination as! SecondViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                switch searchController.isActive {
                    
                case true:
                    secondController.product = filteredProducts[indexPath.row]
                    
                case false:
                    secondController.product = products[indexPath.row]
                }
            }
        }
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredProducts = products.filter { (product: String) -> Bool in
            product.contains(searchController.searchBar.text!)
        }
        
        tableView.reloadData()
    }
    
    // MARK: - UISearchControllerDelegate
    
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    // MARK: - Helpers
    
    func initializeSearchController() {
        searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "Search products"
        searchController.searchBar.scopeButtonTitles = ["All", "Favorites"]
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
            
            definesPresentationContext = true
            searchController.dimsBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.searchBar.sizeToFit()
            
            searchController.loadViewIfNeeded()
        }
    }
}
