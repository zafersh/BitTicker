//
//  BitPoloniexService.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import Foundation
import Starscream

/// This class is used to connect to Poloniex web socket using Starscream.
class BitPoloniexService {
    
    /// Web socket used to connect to Poloniex API.
    var socket = WebSocket(url: URL(string: "wss://api2.poloniex.com")!)
    
    /// Subscribe to web socket
    /// TODO: Wrap the web socket into observable.
    func subscribeToWebSocket() {
        // Do nothing if already connected.
        if self.socket.isConnected == false {
            self.socket.delegate = self
            self.socket.connect()
        }
    }
    
    /// Unsubscribe to the web socket.
    func unsubscribeToWebSocket() {
        if self.socket.isConnected {
            self.socket.disconnect()
        }
    }
    
}

// MARK: - WebSocketDelegate
extension BitPoloniexService : WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("--BitTicker: websocketDidConnect")
        
        // Create command JSON string.
        let params = [  "command" : "subscribe",
                        "channel" : "1002"]
        do {
            let paramsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            if let paramsJson = String(data: paramsData, encoding: .utf8) {
                self.socket.write(string: paramsJson)
            }
        } catch let error {
            assertionFailure("Failed to create JSON commmand string: \(error.localizedDescription)")
        }
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("--BitTicker: websocketDidDisconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("--BitTicker: websocketDidReceiveMessage: \(text)")
        
        let components = text.components(separatedBy: "[")
        if components.count > 2 {
            let tickerMessage = components[2]
            let tickerComponents = tickerMessage.components(separatedBy: ",")
            
            // TODO: Maybe message should be ignored if some parameters are null.
            // So far, assume that all parameters are optionals
            let pairId = Int(tickerComponents[0]) ?? 0
            let lastTradePrice = Double(tickerComponents[1].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let lowestAsk = Double(tickerComponents[2].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let highestBid = Double(tickerComponents[3].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let percentChange24 = Double(tickerComponents[4].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let baseVolume24 = Double(tickerComponents[5].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let quoteVolume24 = Double(tickerComponents[6].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let isFrozen = Bool(tickerComponents[7].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let tradePrice24h = Double(tickerComponents[8].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            let tradePrice24l = Double(tickerComponents[9].trimmingCharacters(in: CharacterSet(charactersIn: "\"")))
            
            let tickerData = TickerData(pairId: pairId, lastTradePrice: lastTradePrice, lowestAsk: lowestAsk, highestBid: highestBid, percentChange24: percentChange24, baseVolume24: baseVolume24, quoteVolume24: quoteVolume24, isFrozen: isFrozen, tradePrice24h: tradePrice24h, tradePrice24l: tradePrice24l)
            
            // TODO: Update the view model.
            
        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("--BitTicker: websocketDidReceiveData")
    }
    
}
