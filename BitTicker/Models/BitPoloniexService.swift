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
        print("+++++ websocketDidConnect")
        
        //        self.socket.write(string: "{ \"command\": \"subscribe\", \"channel\": \"1002\" }")
        self.socket.write(string: "{ \"command\": \"subscribe\", \"channel\": \"203\" }")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("+++++ websocketDidDisconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("+++++ websocketDidReceiveMessage: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("+++++ websocketDidReceiveData")
    }
    
}
