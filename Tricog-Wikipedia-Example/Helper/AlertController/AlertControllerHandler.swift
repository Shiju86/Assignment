//
//  AlertConstant.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import UIKit

typealias NullableCompletion = (() -> ())?
typealias AlertButtonWithAction = (AlertButtonTitle, NullableCompletion)

extension UIViewController {
    func singleButtonAlertWith(title: AlertTitle = .appName, message: Messages,
                               button action: AlertButtonTitle,
                               completionOnButton: NullableCompletion = nil,
                               completionOPresentationOfAlert:  NullableCompletion = nil) {
        let alert = UIAlertController(title: title.value, message: message.value, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: action.value, style: .default, handler: { action in
            if let methodAfterCompletion = completionOnButton {
                methodAfterCompletion()
            }
        }))
        present(alert, animated: true, completion: completionOPresentationOfAlert)
    }
   
    func alertWith(title: AlertTitle = .appName, message: Messages, completionOPresentationOfAlert:  NullableCompletion = nil, actions: AlertButtonWithAction...) {
        let alertController = UIAlertController(title: title.value, message: message.value, preferredStyle: UIAlertControllerStyle.alert)
        for (title, action) in actions {
            let alertAction = UIAlertAction(title: title.value, style:
            title == .cancel ? .destructive : .default) { _ in
                if let actionToPerform = action {
                    actionToPerform()
                }
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: completionOPresentationOfAlert)
    }
}
