//
//  LoginViewController.swift
//  BitTracker
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit
import Firebase

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
        let email = self.emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = self.passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if email.isEmpty || password.isEmpty {
            self.alert(title: "Error", message: "Please fill all fields.")
            return
        }
        
        self.loginWith(email: email, password: password)
    }
    
    /// Login for provided email and password with FireBase.
    ///
    /// - Parameters:
    ///   - email: <#email description#>
    ///   - password: <#password description#>
    func loginWith(email : String, password : String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            // Make sure no error happened.
            if let e = error {
                print("Error: \(e)")
                self.alert(title: "Error", message: e.localizedDescription)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
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

        self.navigationItem.title = "BitTracker"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
    }

}
