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
}
