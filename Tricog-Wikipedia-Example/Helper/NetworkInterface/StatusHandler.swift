//
//  WikipediaModel.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation

final class StatusHandler {
    static func handle(json: NSDictionary) {
        Indicator.shared.hide()
        guard let status = json["batchcomplete"] as? Bool else {
            AppDelegate.shared.window?.rootViewController?.singleButtonAlertWith(message: Messages.internetError, button: .ok)
            return
        }
        print(status)

    }
    
    static func handle(error: Error) {
        Indicator.shared.hide()
        if error.localizedDescription.contains("The Internet connection appears to be offline.") {
            // send to settings app
        } else if error.localizedDescription.contains("JSON could not be serialized because of error") {
             AppDelegate.shared.window?.rootViewController?.singleButtonAlertWith(message: .serverError, button: .ok)
        }else {
            AppDelegate.shared.window?.rootViewController?.singleButtonAlertWith(message: .custom(error.localizedDescription), button: .ok)
        }
    }
}
