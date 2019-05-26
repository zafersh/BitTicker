//
//  LoginViewController.swift
//  PoloniexSample
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit

/// Login View Controller
class LoginViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - LoginViewController
    
    /// Handle tapping login button.
    /// Make sure that the user has entered email and password then
    /// do login.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func loginBtnTapped(_ sender: Any) {
        
    }
    
    /// Handle tapping sign up button.
    /// Show sign up view.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let signUpVC = SignUpViewController(nibName: SignUpViewController.identification, bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
