//
//  SignUpViewController.swift
//  PoloniexSample
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit

/// Sign Up View Controller
class SignUpViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var fullNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - SignUpViewController
    
    /// Handling tapping sign up button.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
    }
    
    /// MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
