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
    var token: String?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let email = email {
            emailTextField.text = email
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        if password.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "User id cannot be empty")
            
        } else if confirmPassword.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Password cannot be empty")
            
        } else {
            
            if let email = email {
            let param = ["email": email,"password": password,"confirm_password": confirmPassword,"passwordToken" : token!]
            resetPassword(param: param)
            
            }
        }
    }
    
    func resetPassword(param: [String: Any]) {
        
        ResetPasswordPostService.executeRequest(param, vc: self, completionHandler: { (response) in
            
            if response.status == true && response.statusCode == 200 {
                self.showSucessAlert(title: "Success", message: response.success)
                
            }
        })
    }
    
    func showSucessAlert(title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
    
            self.navigationController!.popToViewController(self.navigationController!.viewControllers[1], animated: true)
        }
        
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}
