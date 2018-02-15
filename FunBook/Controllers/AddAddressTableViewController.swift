//
//  AddAddressTableViewController.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AddAddressTableViewController: BaseTableViewController {
    
    var vc: AlbumAddressListingTableViewController?
    
    @IBOutlet weak var selectCountryTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressFirstTextField: UITextField!
    @IBOutlet weak var addressSecondTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var array: [CountryModel] = []
    var stateId: String = ""
    var countryId: String = ""
    var index: Int = 0
    
    lazy var picker = UIPickerView()
    lazy var countryPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateTextField.isUserInteractionEnabled = false
        stateTextField.inputView = picker
        selectCountryTextField.inputView = countryPicker
        
        picker.tag = 0
        countryPicker.tag = 1
        
        picker.delegate = self
        countryPicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStates()
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
            showAlert("Error", message: "Country cannot be empty")
            
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
            
            let param = AddressRequestModel(firstName: firstName, lastName: lastName, address1: addressFirst, address2: addressSecond, subUrb: city, state: stateId, country: countryId, postalCode: zipCode).toJSON()
            
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
            print(response)
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
        
        if pickerView.tag == 0 {
            return array[index].states.count
            
        } else if pickerView.tag == 1 {
            return array.count
            
        }
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return array[index].states[row].name
            
        } else if pickerView.tag == 1 {
            return array[row].countryName
            
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        if pickerView.tag == 0 {
            stateId = array[index].states[row].id
            return stateTextField.text = array[index].states[row].name
        } else if pickerView.tag == 1 {
            index = row
            countryId = array[row].countryId
            stateTextField.isUserInteractionEnabled = true
            return selectCountryTextField.text = array[row].countryName
        }
    }
}
