//
//  LoginTableViewController.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "User id cannot be empty")
            
        } else if password.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Password cannot be empty")
            
        } else {
            
            print("validation passed hit login api")
            let param = ["email": email,"password": password,"deviceType": "2","deviceID" : "234567890"]
            
            login(param: param)
        }
    }
    
    func login(param: [String: Any]) {
        
        let param = ["email": "anil.techximum@gmail.com","password": "123456789","deviceType": "2","deviceID" : "234567890"]
        LoginPostService.executeRequest(param, vc: self) { (response) in
        
            print(response)
            
            if response.status == true && response.statusCode == 200 {
                
                
                
            }
            
            
        }
    }
    
    func showAlert(title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        self.present(alertView, animated: true, completion: nil)
    }
}
