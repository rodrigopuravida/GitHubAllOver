//
//  Extensions.swift
//  GitHubAllOver
//
//  Created by Rodrigo Carballo on 1/22/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation

extension String {
  
  //comment
  func validate() -> Bool {
    let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n\\-]", options: nil, error: nil)
    let elements = countElements(self)
    let range = NSMakeRange(0, elements)
    
    let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
    
    if matches > 0 {
      return false
    }
    return true
  }
  
}
