//
//  AddAddressTableViewController.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AddAddressTableViewController: BaseTableViewController {
    
    //    @IBOutlet weak var nameTextField: UITextField!
    //    @IBOutlet weak var emailTextField: UITextField!
    
    var vc: AlbumAddressListingTableViewController?
    
    @IBOutlet weak var selectCountryTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressFirstTextField: UITextField!
    @IBOutlet weak var addressSecondTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var array: [StateModel] = []
    var stateId: String = ""
    
    lazy var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateTextField.inputView = picker
        picker.delegate = self
        
        getStates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let addressFirst = addressFirstTextField.text!
        let addressSecond = addressSecondTextField.text!
        let city = cityTextField.text!
        let state = stateTextField.text!
        let zipCode = zipCodeTextField.text!
        
        if firstName.removeAllSpaces().isEmpty {
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
            
            let param = AddressRequestModel(firstName: firstName, lastName: lastName, address1: addressFirst, address2: addressSecond, subUrb: city, state: stateId, postalCode: zipCode).toJSON()
            
            AddAddressPostService.executeRequest(param!, vc: self, completionHandler: { (response) in
                
                print(response)
                
                if self.vc == nil {
                  self.showSucessAlert("Success", message: response.success)
               
                } else {
                    
                  self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func getStates() {
        StateListingGetService.executeRequest(vc: self) { (response) in
            self.array = response
            self.picker.reloadAllComponents()
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

extension AddAddressTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateId = array[row].id
        return stateTextField.text = array[row].name
    }
}
