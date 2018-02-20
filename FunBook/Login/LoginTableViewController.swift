//
//  LoginTableViewController.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class LoginTableViewController: BaseTableViewController {
    
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Email cannot be empty..")
            
        } else if email.isEmail == false {
           showAlert("Error", message: "Enter valid email..")
            
        } else if password.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Password cannot be empty..")
            
        } else if password.count < 8 {
            showAlert("Error", message: "Password should be 8 character long..")
            
        } else {
            
            print("validation passed hit login api")
            let param = ["email": email,"password": password,"deviceType": "2","deviceID" : "234567890"]
            login(param)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func login(_ param: [String: Any]) {
        
//        let param = ["email": email,"password": password,"deviceType": "2","deviceID" : "234567890"]
        LoginPostService.executeRequest(param, vc: self) { (response) in
            
            print(response)
            
            if response.status == true && response.statusCode == 200 {
                self.userLoginToHome(response.user)
                
            }
        }
    }
    
    func userLoginToHome(_ user: UserModel) {
        
        LoginUtils.setCurrentMemberUser(user)
        let application = UIApplication.shared.delegate as! AppDelegate
        application.setHomeUser()
        
    }
}
