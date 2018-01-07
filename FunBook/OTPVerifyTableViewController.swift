//
//  OTPVerifyTableViewController.swift
//  FunBook
//
//  Created by admin on 07/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class OTPVerifyTableViewController: BaseTableViewController {
    
    @IBOutlet weak var otpTextField: UITextField!
    var email: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegue(withIdentifier: "showResetSegue", sender: self) 
    }
    
    
    @IBAction func verifyButtonTapped(_ sender: Any) {
        
        let otp = otpTextField.text!
        
        if otp.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Otp Field is Empty")
            
        } else {
            
            if let email = email {
                let param = ["email": email ,"otp": otp]
        
                OTPVerifyPostService.executeRequest(param, vc: self, completionHandler: { (response) in
                    
                    if response.status == true && response.statusCode == 200 {
                        self.performSegue(withIdentifier: "showResetSegue", sender: self)
                        
                    }
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResetSegue" {
            let dvc = segue.destination as! ResetPasswordTableViewController
            dvc.email = email
        }
    }
}
