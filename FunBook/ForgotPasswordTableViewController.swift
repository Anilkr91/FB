//
//  ForgotPasswordTableViewController.swift
//  FunBook
//
//  Created by admin on 05/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class ForgotPasswordTableViewController: BaseTableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.performSegue(withIdentifier: "showOTPSegue", sender: self)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        let email = emailTextField.text!
        
        if email.removeAllSpaces().isEmpty {
            
            showAlert(title: "Error", message: "Email field is empty")
        } else {
            
            let param = ["email": email]
            forgotPassword(param: param)
        }
    }
    
    func forgotPassword(param: [String: Any]) {
        ForgotPasswordPostService.executeRequest(param, vc: self) { (response) in
            if response.status == true && response.statusCode == 200 {
                self.showAlert(title: "Success", message: response.success)
                
                self.performSegue(withIdentifier: "showOTPSegue", sender: self)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showOTPSegue" {
            
         let dvc = segue.destination as! OTPVerifyTableViewController
            dvc.email = emailTextField.text!
            
            
        }
    }
}
