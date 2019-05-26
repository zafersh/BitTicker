//
//  HomeViewController.swift
//  PoloniexSample
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit
import Firebase

import Starscream

/// Home View Controller
class HomeViewController: UIViewController {
    
    // MARK:- Properties
    
    @IBOutlet weak var welcomeLbl: UILabel!
    
    var socket = WebSocket(url: URL(string: "wss://api2.poloniex.com")!)
    
    // MARK: - HomeViewController
    
    @objc func signout() {
        do {
            try Auth.auth().signOut()
            self.presentLoginView(animated: true)
        } catch let error {
            print("Error while sign out: \(error)")
        }
    }
    
    /// Present login view.
    func presentLoginView(animated : Bool) {
        let navController = UINavigationController(rootViewController: LoginViewController())
        self.present(navController, animated: animated, completion: nil)
    }
    
    /// Subscribe to web socket
    /// TODO: Wrap the web socket into observable.
    func subscribeToWebSocket() {
        self.socket.delegate = self
        self.socket.connect()
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signout))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Poloniex Sample"
        
        if let currentUser = Auth.auth().currentUser {
            
            // Get user name.
            Database.database().reference().child("users").child(currentUser.uid).child("fullName").observeSingleEvent(of: .value) { (snapshot) in
                
                // Show user full name.
                guard let fullName = snapshot.value as? String else {return}
                self.welcomeLbl.text = "Welcome \(fullName)"
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.welcomeLbl.alpha = 1
                })
                
                self.subscribeToWebSocket()
                
            }
            
        } else {
            self.presentLoginView(animated: false)
        }
        
    }

}

extension HomeViewController : WebSocketDelegate {
    
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
