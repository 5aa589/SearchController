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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchController.active {
            
        case true:
            return filteredProducts.count
            
        case false:
            return products.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        switch searchController.active {
            
        case true:
            cell.textLabel?.text = filteredProducts[indexPath.row]
            
        case false:
            cell.textLabel?.text = products[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detail", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let secondController = segue.destinationViewController as! SecondViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                switch searchController.active {
                    
                case true:
                    secondController.product = filteredProducts[indexPath.row]
                    
                case false:
                    secondController.product = products[indexPath.row]
                }
            }
        }
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredProducts = products.filter { (product: String) -> Bool in
            product.containsString(searchController.searchBar.text!)
        }
        
        tableView.reloadData()
    }
    
    // MARK: - UISearchControllerDelegate
    
    func willPresentSearchController(searchController: UISearchController) {

    }
    
    func willDismissSearchController(searchController: UISearchController) {

    }
    
    // MARK: - Helpers
    
    func initializeSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.placeholder = "Search products"
        searchController.searchBar.scopeButtonTitles = ["All", "Favorites"]
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self

        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.sizeToFit()

        searchController.loadViewIfNeeded()
    }
}
