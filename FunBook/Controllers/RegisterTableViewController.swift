//
//  RegisterTableViewController.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class RegisterTableViewController: BaseTableViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let name = fullNameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if name.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Name Field is Empty")
            
        } else if email.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Email cannot be empty")
            
        } else if password.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Password cannot be empty")
            
        } else {
            
            print("validation passed hit api")
            
            let param = ["name": name,"email": email,"password": password]
            register(param)
        }
    }
    
    func register(_ param: [String: Any]) {

        RegisterPostService.executeRequest(param, vc: self) { (response) in
            
            if response.status == true && response.statusCode == 200 {
               self.showSucessAlert("Success", message: response.success)
            }
        }
    }
    
    func showSucessAlert(_ title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }
}
