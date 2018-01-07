//
//  ResetPasswordTableViewController.swift
//  FunBook
//
//  Created by admin on 07/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class ResetPasswordTableViewController: BaseTableViewController {

    var email: String?
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordToken: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func resetButtonTapped(_ sender: Any) {
    
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        let token = passwordToken.text!
        
        if password.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "User id cannot be empty")
            
        } else if confirmPassword.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Password cannot be empty")
            
        } else if token.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Password cannot be empty")

            
        } else {
           
            self.navigationController!.popToViewController(self.navigationController!.viewControllers[1], animated: true)
            print("validation passed hit login api")
            
            if let email = email {

                let param = ["email": email,"password": password,"confirm_password": confirmPassword,"passwordToken" : token]
                
//                ResetPasswordPostService.executeRequest(param, vc: self, completionHandler: { (response) in
//                    print(response)
//                })
            }
        }
    }
}
