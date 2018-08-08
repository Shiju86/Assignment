//
//  AlertConstant.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation

enum AlertTitle {
  case appName
  
  var value: String {
    switch self {
    case .appName: return "Wikipedia"
    }
  }
}

enum Messages {

  case custom(String)
  case internetError, serverError, enterSearchText

  var value: String {
    switch self {
   
    case .custom(let message) : return message
    case .internetError: return "No Internet connection, please try again"
    case .serverError: return "Server error, please try again"
    case .enterSearchText: return "Please enter some text to search"
        
    }
  }
}


enum AlertButtonTitle {
    case ok, cancel, settings, yes, no
    var value: String {
      switch self {
      case .ok: return "OK"
      case .cancel: return "Cancel"
      case .settings: return "Settings"
      case .yes: return "YES"
      case .no: return "NO"
      }
    }
}
