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
  var search : Repository!
  
  init() {
    let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    self.urlSession = NSURLSession(configuration: ephemeralConfig)
  }
  
  func fetchRepositoriesBasedOnSearch(searchString : String, callback : ([String : AnyObject]?, String?) -> (Void)) {
    
    let url = NSURL(string: "http://127.0.0.1:3000")
    let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
      
      if let httpRes = response as? NSHTTPURLResponse {
        println("status code=",httpRes.statusCode)
        if httpRes.statusCode == 200 {
          //println(NSString(data: data, encoding: NSUTF8StringEncoding))
          
          if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject] {
            println("I made into Serialization of json")
            //instantiate a Tweet class
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              callback(jsonDict, nil)
            })
          }
          
        }
      } else {
        println("error \(error)") // print the error!
      }

    })
    dataTask.resume()
    
  }
  






}
