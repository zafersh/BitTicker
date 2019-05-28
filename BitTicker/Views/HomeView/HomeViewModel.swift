//
//  HomeViewModel.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// View model for home view.
class HomeViewModel {
    
    /// Service used to get data from Poloniex web socket API.
    var poloniexService : BitPoloniexService!
    
    /// An observable dictionary of currency pair ID and ticker data.
    let data : BehaviorRelay<[Int : TickerData]> = BehaviorRelay(value: [:])
    
    init() {
        self.poloniexService = BitPoloniexService(delegate: self)
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

// MARK: - <#BitPoloniexServiceDelegate#>
extension HomeViewModel : BitPoloniexServiceDelegate {
    
    /// Update observable data when ticker data is received.
    ///
    /// - Parameter tickerData: <#tickerData description#>
    func tickerDataReceived(tickerData: TickerData) {
        var data = self.data.value
        data[tickerData.pairId] = tickerData
        self.data.accept(data)
    }
    
}
