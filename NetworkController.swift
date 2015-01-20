//
//  NetworkController.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/19/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

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
    if let accessToken = NSUserDefaults.standardUserDefaults().objectForKey(self.accessTokenUserDefaultsKey) as? String {
      self.accessToken = accessToken
    }

  }
  
  func requestAccessToken() {
    let url = "https://github.com/login/oauth/authorize?client_id=\(self.clientID)&scope=user,repo"
    
    UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    
  }
  
  func handleCallbackURL(url : NSURL) {
    let code = url.query
    
    //This is one way you can pass back info in a POST, via passing items as parameters in the URL
    
    //    let oauthURL = "https://github.com/login/oauth/access_token?\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)"
    //    let postRequest = NSMutableURLRequest(URL: NSURL(string: oauthURL)!)
    //    postRequest.HTTPMethod = "POST"
    //postRequest.HTTPBody
    
    //THis is the 2nd way you can pass back info with a POST, and this is passing back info in the Body of the HTTP Request
    
    let bodyString = "\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)"
    let bodyData = bodyString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    let length = bodyData!.length
    let postRequest = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token")!)
    postRequest.HTTPMethod = "POST"
    postRequest.setValue("\(length)", forHTTPHeaderField: "Content-Length")
    postRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    postRequest.HTTPBody = bodyData
    
    let dataTask = self.urlSession.dataTaskWithRequest(postRequest, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
          case 200...299:
            let tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
            println(tokenResponse)
            
            let accessTokenComponent = tokenResponse?.componentsSeparatedByString("&").first as String
            let accessToken = accessTokenComponent.componentsSeparatedByString("=").last
            println(accessToken!)
            
            NSUserDefaults.standardUserDefaults().setObject(accessToken!, forKey: self.accessTokenUserDefaultsKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
          default:
            println("default case")
          }
        }
      }
      
    })
    dataTask.resume()
    
  }
  
  func fetchRepositoriesBasedOnSearch(searchString : String, callback : ([Repository]?, String?) -> (Void)) {
    
    let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchString)")
    //Authorization: token OAUTH-TOKEN
    println(self.accessToken)
    
    let request = NSMutableURLRequest(URL: url!)
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")
    
    //let url = NSURL(string: "http://127.0.0.1:3000")
    
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
