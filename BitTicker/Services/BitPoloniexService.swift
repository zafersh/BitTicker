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
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("--BitTicker: websocketDidReceiveData")
    }
    
}
