//
//  Repository.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation

struct Repository {
  
  
  let name : String
  
  
  init(jsonDictionary : [String : AnyObject]) {
    self.name = jsonDictionary["name"] as String
  }
  
}
