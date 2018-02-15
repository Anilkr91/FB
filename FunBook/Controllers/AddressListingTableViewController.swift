//
//  AddressListingTableViewController.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AddressListingTableViewController: BaseTableViewController {
    
    var array: [AddressResponseModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getAddresses()
        
    }
    
    func getAddresses() {
        AllAddressGetService.executeRequest(vc: self) { (response) in
            self.array = response
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addAddressButton(_ sender: Any) {
        performSegue(withIdentifier: "addAddressSegue", sender: self)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressListingTableViewCell
        
        cell.info = array[indexPath.section]
        
        return cell
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            DeleteAddressPostService.executeRequest(addressId: array[indexPath.section].id, vc: self, completionHandler: { (response) in
                self.getAddresses()
            })
        }
    }
}
