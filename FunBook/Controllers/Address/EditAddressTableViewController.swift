//
//  EditAddressTableViewController.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class EditAddressTableViewController: BaseTableViewController {

    @IBOutlet weak var selectCountryTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressFirstTextField: UITextField!
    @IBOutlet weak var addressSecondTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        let country = selectCountryTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let addressFirst = addressFirstTextField.text!
        let addressSecond = addressSecondTextField.text!
        let city = cityTextField.text!
        let state = stateTextField.text!
        let zipCode = zipCodeTextField.text!
        
        
        if country.removeAllSpaces().isEmpty {
            showAlert("Error", message: "country cannot be empty")
            
        } else if firstName.removeAllSpaces().isEmpty {
            showAlert("Error", message: "firstName cannot be empty")
            
        } else if lastName.removeAllSpaces().isEmpty {
            showAlert("Error", message: "lastName cannot be empty")
            
        } else if addressFirst.removeAllSpaces().isEmpty {
            showAlert("Error", message: "addressFirst cannot be empty")
            
        } else if addressSecond.removeAllSpaces().isEmpty {
            showAlert("Error", message: "addressSecond cannot be empty")
            
        } else if city.removeAllSpaces().isEmpty {
            showAlert("Error", message: "city cannot be empty")
            
        } else if state.removeAllSpaces().isEmpty {
            showAlert("Error", message: "state cannot be empty")
            
        } else if zipCode.removeAllSpaces().isEmpty {
            showAlert("Error", message: "zipCode cannot be empty")
            
        } else  {
            
            print("hit api")
            
        }
    }
}
