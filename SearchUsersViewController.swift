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
  
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if (fromVC is SearchUsersViewController && toVC is UserDetailViewController) {
      //return the animation controller
      return ToUserDetailAnimationController()
    }
    return nil
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    println("I'm here")
    
    
    if segue.identifier == "SHOW_USER_DETAIL" {
      println("Im inside if")
      let destinationVC = segue.destinationViewController as UserDetailViewController
      let selectedIndexPath = self.collectionView.indexPathsForSelectedItems().first  as NSIndexPath
      destinationVC.selectedUser = self.users[selectedIndexPath.row]
      
    }
  }
}
