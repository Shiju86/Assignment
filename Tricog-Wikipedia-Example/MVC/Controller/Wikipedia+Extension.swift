//
//  Wikipedia+Extension.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation
import ObjectMapper

extension WikipediaVC {
  
    //MARK: - Get Wikipedia Search Result Webservice
  func getWikipediaSearchResultWebservice(searchUser: String, pageLimit: Int ,successHandler:@escaping (_ arrResults: [WikipediaModel]) -> ()) {
  
    WebService.shared.getDataFrom(api: "\(Apis.kSearchUser)\(searchUser)&gpslimit=\(pageLimit)", showIndicator: true,useToken: false, responseClosure: { (sucess,response) in
      
        var arrResults = [WikipediaModel]()
      
          if let query = response["query"] as? NSDictionary {
            if let data = query["pages"] as? [[String : AnyObject]]{
              for dic in data{
                if  let resultModel = Mapper<WikipediaModel>().map(JSONObject: dic){
                  arrResults.append(resultModel)
                  
                }
              }
            }
          }
        successHandler(arrResults)

    })
  }
  
}
