//
//  User.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/21/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

struct User {
  let name : String
  let avatarURL : String
  var avatarImage : UIImage?
  var login : String
  var score : Double
  
  init (jsonDictionary : [String : AnyObject]) {
    self.name = jsonDictionary["login"] as! String
    self.avatarURL = jsonDictionary["avatar_url"] as! String
    self.login = jsonDictionary["login"] as! String
    self.score = jsonDictionary["score"] as! Double
  }
}
