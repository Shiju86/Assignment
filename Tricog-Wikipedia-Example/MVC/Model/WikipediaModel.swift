//
//  WikipediaModel.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation
import ObjectMapper

class WikipediaModel: Mappable {
  
  var title: String?
  var thumbnail: String?
  var descriptions: [String] = []
  
  required init?(map: Map)
  {
  }
  
  func mapping(map: Map)
  {
    title <- map["title"]
    thumbnail <- map["thumbnail.source"]
    descriptions <- map["terms.description"]
  }
}
