//
//  SignUpViewController.swift
//  PoloniexSample
//
//  Created by Thafer Shahin on 5/26/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit
import Firebase

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
        let fullName = self.fullNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = self.emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = self.passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if fullName.isEmpty || email.isEmpty || password.isEmpty {
            self.alert(title: "Error", message: "Please fill all fields.")
            return
        }
        
        self.signUpWith(fullName: fullName, email: email, password: password)
    }
    
    /// Create a new user with provided full name, email and password at FireBase.
    ///
    /// - Parameters:
    ///   - fullName: <#fullName description#>
    ///   - email: <#email description#>
    ///   - password: <#password description#>
    func signUpWith(fullName: String, email : String, password : String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            // Make sure no error happened.
            if let e = error {
                print("Error: \(e)")
                self.alert(title: "Error", message: e.localizedDescription)
                return
            }
            
            // Get user ID.
            guard let uid = result?.user.uid else {return}
            
            let userInfo = ["fullName" : fullName, "email" : email]
            
            Database.database().reference().child("users").child(uid).updateChildValues(userInfo, withCompletionBlock: { (error, ref) in
                
                // Make sure no error happened.
                if let e = error {
                    print("Error while updating users database: \(e)")
                    self.alert(title: "Error", message: "Error while creating a user!")
                    return
                }
                
                // Back to Home view.
                self.dismiss(animated: true, completion: nil)
                
            })
            
            
        }
        
    }
    
    /// MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Sign Up"
        
    }

}
