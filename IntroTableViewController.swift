//
//  IntroTableViewController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class IntroTableViewController: UITableViewController {
  
  var networkController : NetworkController!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
      self.networkController = appDelegate.networkController
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.delegate = nil
    if self.networkController.accessToken == nil {
      self.networkController.requestAccessToken()
    }
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
