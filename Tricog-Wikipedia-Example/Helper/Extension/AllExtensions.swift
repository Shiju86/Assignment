//
//  AllExtensions.swift
//  Tricog-Wikipedia-Example
//
//  Created by Igniva-Ios-Yogesh on 08/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var isBlank: Bool {
        return (self.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
   
    var trimmedText: String {
        return (self.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UITableView {
   
    func reloadTableData() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
