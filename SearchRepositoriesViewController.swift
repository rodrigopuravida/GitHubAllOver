//
//  SearchRepositoriesViewController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class SearchRepositoriesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
  
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  let networkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.dataSource = self
      self.searchBar.delegate = self
        }
  
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
      }
      
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as UITableViewCell
        return cell
      }


      
//      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as UITableViewCell
//        return cell
//      }
      //MARK: UISearchBarDelegate
      
      func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println(searchBar.text)
        
        self.networkController.fetchRepositoriesBasedOnSearch(searchBar.text, callback: { (items, errorDescription) -> (Void) in
          
        })

        searchBar.resignFirstResponder()
        //make your network call here based on the search term
      }
}





