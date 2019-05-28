//
//  Numbers+Additions.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import Foundation

// MARK: - Extension for optional Double
extension Optional where Wrapped == Double {
    
    /// Return a 8 decimal digitis string value of this double or
    /// a dash if this double is nil.
    ///
    /// - Returns: <#return value description#>
    func tickerFormattesString() -> String {
        if let v = self {
            return String(format: "%.8f", v)
        } else {
            return "-"
        }
    }
    
}

// MARK: - Extension for Double
extension Double {
    
    /// Return a 8 decimal digitis string value of this double or
    /// a dash if this double is nil.
    ///
    /// - Returns: <#return value description#>
    func tickerFormattesString() -> String {
        return String(format: "%.8f", self)
    }
    
}
