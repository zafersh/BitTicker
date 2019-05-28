//
//  HomeViewController.swift
//  BitTracker
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

/// Home View Controller
class HomeViewController: UIViewController {
    
    // MARK:- Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Associated view model.
    let viewModel = HomeViewModel()
    
    /// Observers dispose bag.
    private let disposeBag = DisposeBag()
    
    // MARK: - HomeViewController
    
    @objc func signout() {
        do {
            self.viewModel.unsubscribeToWebSocket()
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
        
        // Register custom table view cells.
        self.tableView.register(DefaultTickerDataTableViewCell.self, forCellReuseIdentifier: DefaultTickerDataTableViewCell.identification)
        
        // Bind table view to view model observable data.
        self.viewModel.data.bind(to: self.tableView
            .rx
            .items(cellIdentifier: DefaultTickerDataTableViewCell.identification,
                   cellType: DefaultTickerDataTableViewCell.self)) {
                    row, chocolate, cell in
//                    cell.configureWithChocolate(chocolate: chocolate)
            }
            .disposed(by: disposeBag) //5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "BitTracker"
        
        if let currentUser = Auth.auth().currentUser {
            
            // Get user name.
            Database.database().reference().child("users").child(currentUser.uid).child("fullName").observeSingleEvent(of: .value) { (snapshot) in
                
                // Show user full name.
                guard let fullName = snapshot.value as? String else {return}
                self.navigationItem.prompt = "Welcome \(fullName)"
                
                self.viewModel.subscribeToWebSocket()
                
            }
            
        } else {
            self.presentLoginView(animated: false)
        }
        
    }

}
