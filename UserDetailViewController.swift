//
//  UserDetailViewController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/21/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  var selectedUser : User!
  
  @IBOutlet weak var loginLbl: UILabel!
 
  @IBOutlet weak var scoreLbl: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var double = selectedUser.score
    var stringFromDouble = "\(double)"
    
    self.imageView.image = selectedUser.avatarImage
    self.loginLbl.text = "Login: " + selectedUser.login
    self.scoreLbl.text = "Score: " + stringFromDouble
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}