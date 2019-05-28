//
//  UITableViewCell+Additions.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit

// MARK: - Extension for UIViewController
extension UITableViewCell {
    
    /// Returns name of the cell to be used as an ID.
    static var identification: String {
        return String(describing: self)
    }
    
}
