//
//  EditProfileTableViewController.swift
//  FunBook
//
//  Created by admin on 05/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class EditProfileTableViewController: BaseTableViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // User
    let user = LoginUtils.getCurrentMemberUserLogin()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewWithUserData()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }

    func setupViewWithUserData() {
        nameTextField.text = user.name
        emailTextField.text = user.email
    }
   
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        let name = nameTextField.text!
        
        
        if name.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "User id cannot be empty")
            
        } else {
            
            print("validation passed hit api")
            let param = ["name": name]
            
            editprofile(param: param)
        }
    }
    
    func editprofile(param: [String: Any]) {
        
        EditProfilePostService.executeRequest(param, vc: self) { (response) in
            
            print(response)
            
            if response.status == true && response.statusCode == 200 {
               print("Success")
                
                 LoginUtils.setCurrentMemberUserLogin(response.user)
                
                self.showSucessAlert(title: "Success", message: response.success)
//                self.showAlert
                
            }
        }
    }
    
    
    func showSucessAlert(title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }
}
