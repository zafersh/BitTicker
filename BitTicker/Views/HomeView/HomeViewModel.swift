//
//  HomeViewModel.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import Foundation

/// View model for home view.
class HomeViewModel {
    
    var poloniexService : BitPoloniexService!
    
    init() {
        self.poloniexService = BitPoloniexService()
    }
    
    /// Subscribe to web socket
    func subscribeToWebSocket() {
        self.poloniexService.subscribeToWebSocket()
    }
    
    /// Unsubscribe to the web socket.
    func unsubscribeToWebSocket() {
        self.poloniexService.unsubscribeToWebSocket()
    }
    
}
