//
//  HomeViewController.swift
//  BitTracker
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit
import Firebase

/// Home View Controller
class HomeViewController: UIViewController {
    
    // MARK:- Properties
    
    @IBOutlet weak var welcomeLbl: UILabel!
    
    var poloniexService : BitPoloniexService!
    
    // MARK: - HomeViewController
    
    @objc func signout() {
        do {
            self.poloniexService.unsubscribeToWebSocket()
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
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signout))
        
        // Initialize poloniex service.
        self.poloniexService = BitPoloniexService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "BitTracker"
        
        if let currentUser = Auth.auth().currentUser {
            
            // Get user name.
            Database.database().reference().child("users").child(currentUser.uid).child("fullName").observeSingleEvent(of: .value) { (snapshot) in
                
                // Show user full name.
                guard let fullName = snapshot.value as? String else {return}
                self.welcomeLbl.text = "Welcome \(fullName)"
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.welcomeLbl.alpha = 1
                })
                
                self.poloniexService.subscribeToWebSocket()
                
            }
            
        } else {
            self.presentLoginView(animated: false)
        }
        
    }

}
