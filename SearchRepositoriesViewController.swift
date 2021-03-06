//
//  SearchRepositoriesViewController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class SearchRepositoriesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
  
  
  @IBOutlet weak var nsmeLbl: UILabel!
  @IBOutlet weak var usernameLbl: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  var networkController : NetworkController!
  var repositories = [Repository]()
 

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.dataSource = self
      self.searchBar.delegate = self
      
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      self.networkController = appDelegate.networkController
      
        }
  
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
      }
      
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath)as! UITableViewCell
        cell.textLabel?.text = self.repositories[indexPath.row].name
        return cell
      }
//      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as UITableViewCell
//        return cell
//      }
      //MARK: UISearchBarDelegate
      
      func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println(searchBar.text)
        
        NetworkController.sharedNetworkController.fetchRepositoriesBasedOnSearch(searchBar.text, callback: { (items, errorDescription) -> (Void) in
        println(items)
        self.repositories = items!
          
          self.tableView.reloadData()

        println("I am back at SearchRepositoryController")
        })

        searchBar.resignFirstResponder()
        //make your network call here based on the search term
      }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validate()
  }
  // MARK: - Navigationrl
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_WEB" {
      let destinationVC = segue.destinationViewController as! WebViewController
      let selectedIndexPath = self.tableView.indexPathForSelectedRow()
      let repo = self.repositories[selectedIndexPath!.row]
      println(repo)
      destinationVC.url = repo.url
    }
  }  
}





