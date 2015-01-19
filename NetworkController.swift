//
//  NetworkController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation

class NetworkController {
  
  var urlSession : NSURLSession
  
  init() {
    let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    self.urlSession = NSURLSession(configuration: ephemeralConfig)
  }
  
  func fetchRepositoriesBasedOnSearch(searchString : String, callback : ([AnyObject]?, String) -> (Void)) {
    let url = NSURL(string: "http://127.0.0.1.3000")
    
    let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        println("I am inside fetchRepositoriesBasedOnSearch")
      }
    })
    dataTask.resume()
    
    
    
  }






}
