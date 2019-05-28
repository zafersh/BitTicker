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

/// Enumerable for all possible view modes.
///
/// - DefaultMode: <#DefaultMode description#>
/// - ExpandedMode: <#ExpandedMode description#>
enum ViewModes {
    case DefaultMode
    case ExpandedMode
}

/// Home View Controller
class HomeViewController: UIViewController {
    
    // MARK:- Properties
    
    @IBOutlet weak var welcomeLbl: UILabel!
    
    @IBOutlet weak var comparePriceTF: UITextField!
    
    @IBOutlet weak var defaultViewBtn: UIButton!
    
    @IBOutlet weak var expandViewBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Associated view model.
    let viewModel = HomeViewModel()
    
    /// Current view mode.
    var viewMode = ViewModes.DefaultMode
    
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
    
    // MARK: - IBActions
    
    /// Reconfigure all table's cells when compare price change.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func comparePriceValueChanged(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    /// Switch to default view.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func defaultViewBtnTapped(_ sender: Any) {
        if self.viewMode != .DefaultMode {
            self.viewMode = .DefaultMode
            UIView.animate(withDuration: 0.2) {
                self.defaultViewBtn.alpha = 1
                self.expandViewBtn.alpha = 0.5
            }
            self.tableView.reloadData()
        }
    }
    
    /// Switch to expanded view.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func expandedViewBtnTapped(_ sender: Any) {
        if self.viewMode != .ExpandedMode {
            self.viewMode = .ExpandedMode
            UIView.animate(withDuration: 0.2) {
                self.defaultViewBtn.alpha = 0.5
                self.expandViewBtn.alpha = 1
            }
            self.tableView.reloadData()
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signout))
        
        // Register custom table view cells.
        self.tableView.register(UINib(nibName: DefaultTickerDataTableViewCell.identification, bundle: nil), forCellReuseIdentifier: DefaultTickerDataTableViewCell.identification)
        
        // Bind table view to view model observable data.
        self.viewModel.data.bind(to: self.tableView
            .rx
            .items(cellIdentifier: DefaultTickerDataTableViewCell.identification,
                   cellType: DefaultTickerDataTableViewCell.self)) {
                    row, tickerData, cell in
                    let comparePrice = self.comparePriceTF.text ?? "0"
                    cell.configureWithTickerData(tickerData: tickerData.value, comparePrice: Double(comparePrice) ?? 0, viewMode: self.viewMode)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "BitTracker"
        
        if let currentUser = Auth.auth().currentUser {
            
            // Get user name.
            Database.database().reference().child("users").child(currentUser.uid).child("fullName").observeSingleEvent(of: .value) { (snapshot) in
                
                // Show user full name.
                guard let fullName = snapshot.value as? String else {return}
                self.welcomeLbl.text = "Welcome \(fullName)"
                
                self.viewModel.subscribeToWebSocket()
                
            }
            
        } else {
            self.presentLoginView(animated: false)
        }
        
    }

}
