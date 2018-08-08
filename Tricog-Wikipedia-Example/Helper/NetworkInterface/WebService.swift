//
//  WikipediaModel.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias WebServiceResponse = (Bool, NSDictionary) -> ()

final class WebService {
    
    static let shared = WebService()
    fileprivate init(){}

    func getDataFrom(api: String, showIndicator: Bool? = true, useToken: Bool? = true, responseClosure: @escaping WebServiceResponse) {
        
        if !NetworkReachabilityManager()!.isReachable {
            displayAlertWithSettings()
            return
        }
        
        if showIndicator! {
            Indicator.shared.show()
        }
      
        let apiString = ApiEndPoints.getWikipediaResult.value + (api as String)
        print(apiString)
        
        debugPrint("********************************* API Request **************************************")
        debugPrint("Request URL:\(apiString)")
        debugPrint("************************************************************************************")
        
        request(apiString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                Indicator.shared.hide()
                switch response.result {
                case .success(_):
                    print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                    if let data = response.result.value as? NSDictionary {
                        
                         responseClosure(true, data)
                        
                     /*   if let statusCode = data["batchcomplete"] as? Bool {
                            if statusCode == true {
                              
                                responseClosure((statusCode == true), data)
                            } else {
                                StatusHandler.handle(json: data)
                            }
                        }
 */
                    }
                case .failure(let error):
                    StatusHandler.handle(error: error)
                }
        }
    }

    func displayAlertWithSettings() {
        let okAction: AlertButtonWithAction = (.ok, nil)
        let settings: AlertButtonWithAction = (.settings, AppDelegate.shared.methodToOpenSettings)
        showAlertWithOpenSettings(message: .internetError, actions: settings, okAction)
    }
    
    func showAlertWithOpenSettings(title: AlertTitle = .appName, message: Messages,
                                   completionOPresentationOfAlert:  NullableCompletion = nil,
                                   actions: AlertButtonWithAction...) {
        let topController = AppDelegate.shared.window?.rootViewController
        let alertController = UIAlertController(title: title.value, message: message.value, preferredStyle: UIAlertControllerStyle.alert)
        for (title, action) in actions {
            let alertAction = UIAlertAction(title: title.value, style: .default) { _ in
                if let actionToPerform = action {
                    actionToPerform()
                }
            }
            alertController.addAction(alertAction)
        }
        topController?.present(alertController, animated: true, completion: completionOPresentationOfAlert)
    }
    
}

