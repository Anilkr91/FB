//
//  ChangePasswordTableViewController.swift
//  FunBook
//
//  Created by admin on 21/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: BaseTableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = LoginUtils.getCurrentMemberUserLogin() {
            emailTextField.text = user.email
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        let currentPassword = currentPasswordTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        if currentPassword.removeAllSpaces().isEmpty {
            showAlert("Error", message: "current password cannot be empty")
        }
            
        else if password.removeAllSpaces().isEmpty {
            showAlert("Error", message: "password cannot be empty")
            
        } else if confirmPassword.removeAllSpaces().isEmpty {
            showAlert("Error", message: "confirm password cannot be empty")
            
        } else if password != confirmPassword {
            
            showAlert("Error", message: "password and confirm password mismatch")
            
        } else {
            
            //            current_password,password,confirm_password
            
            let param = ["current_password": currentPassword,"password": password,"confirm_password": confirmPassword]
            changePassword(param)
            
        }
    }
    
    
    func changePassword(_ param: [String: Any]) {
        
        ChangePasswordPostService.executeRequest(param, vc: self, completionHandler: { (response) in
            
//            if response.status == true && response.statusCode == 200 {
//                self.showSucessAlert("Success", message: response.success)
            
//            }
        })
    }
    
    func showSucessAlert(_ title: String, message: String) {
        
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
