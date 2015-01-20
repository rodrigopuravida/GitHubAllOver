//
//  NetworkController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation

class NetworkController {
  
  //singleton setup
  class var sharedNetworkController : NetworkController {
    struct Static {
      static let instance : NetworkController = NetworkController()
    }
    return Static.instance
  }
  
  
  let clientSecret = "993f5a4f770fdf881053016eb0f803a549362890"
  let clientID = "bc49fc7c020ac3e9a6d4"
  var urlSession : NSURLSession
  let accessTokenUserDefaultsKey = "accessToken"
  var accessToken : String?

  
  init() {
    let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    self.urlSession = NSURLSession(configuration: ephemeralConfig)
  }
  
  func fetchRepositoriesBasedOnSearch(searchString : String, callback : ([Repository]?, String?) -> (Void)) {
    
    let url = NSURL(string: "http://127.0.0.1:3000")
    let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
      
      if let httpRes = response as? NSHTTPURLResponse {
        
        println("status code=",httpRes.statusCode)
        if httpRes.statusCode == 200 {
          
          if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject] {
            println("I made into Serialization of json")
            //println(jsonDict)

            if let items = jsonDict["items"] as? [AnyObject] {
              var repos = [Repository]()
              //println(items)
              for object in items {
                if let repoItem = object as? [String : AnyObject] {
                  let repo = Repository(jsonDictionary: repoItem)
                  repos.append(repo)
                  //println(repos)
                  }
              }
              //instantiate a Repository class
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                callback(repos, nil)
              })

            }
            
          }
          
        }
      } else {
        println("error \(error)") // print the error!
      }
    })
    dataTask.resume()    
  }
  






}
