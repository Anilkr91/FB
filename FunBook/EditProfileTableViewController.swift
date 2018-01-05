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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // User
    let user = LoginUtils.getCurrentMemberUserLogin()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewWithUserData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewWithUserData() {
        
        emailTextField.text = user.email
        
    }
}
