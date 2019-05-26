//
//  UIViewController+Additions.swift
//  PoloniexSample
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit

// MARK: - Extension for UIViewController
extension UIViewController {
    
    /// Returns name of the view controller to be used as an ID.
    static var identification: String {
        return String(describing: self)
    }
    
    /// Short hand to show alert with default OK button.
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    func alert(title: String, message :String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
