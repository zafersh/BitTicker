//
//  TickerData.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import Foundation

/// Model for Poloniex ticker data.
struct TickerData {
    
    /// Currency pair id
    var pairId : Int
    
    /// Last trade price
    var lastTradePrice : Double?
    
    /// Lowest ask
    var lowestAsk : Double?
    
    /// Highest bid
    var highestBid : Double?
    
    /// Percent change in last 24 hours
    var percentChange24 : Double?
    
    /// Base currency volume in last 24 hours
    var baseVolume24 : Double?
    
    /// Quote currency volume in last 24 hours
    var quoteVolume24 : Double?
    
    /// Is frozen
    var isFrozen : Bool?
    
    /// Highest trade price in last 24 hours
    var tradePrice24h : Double?
    
    /// Lowest trade price in last 24 hours
    var tradePrice24l : Double?
    
}
