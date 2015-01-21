//
//  SearchUsersViewController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/21/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var users = [User]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        self.navigationController?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
    cell.imageView.image = nil
    var user = self.users[indexPath.row]
    if user.avatarImage == nil {
      NetworkController.sharedNetworkController.fetchAvatarImageForURL(user.avatarURL, completionHandler: { (image) -> (Void) in
        cell.imageView.image = image
        user.avatarImage = image
        self.users[indexPath.row] = user
      })
    } else {
      cell.imageView.image = user.avatarImage
    }
    return cell
  }

  
  
  //MARK: UISearchBarDelegate
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    
    //TODO: USING SINGLETON.  LOOK AT THIS EXAMPLE
    NetworkController.sharedNetworkController.fetchUsersForSearchTerm(searchBar.text, callback: { (users, errorDescription) -> (Void) in
      if errorDescription == nil {
        self.users = users!
        self.collectionView.reloadData()
      }
    })
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
