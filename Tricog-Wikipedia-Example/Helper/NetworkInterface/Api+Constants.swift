//
//  WikipediaModel.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation

enum ApiEndPoints {
    private var base: String {
      return "https://en.wikipedia.org//w/api.php?"
    }

  case getWikipediaResult
  
    var value: String {
        switch self {
          
        case .getWikipediaResult: return "\(self.base)action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&"
        }
    }
}

enum Apis {
  
    static let kSearchUser = "gpssearch="
}


