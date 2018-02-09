//
//  AddressListingTableViewController.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AddressListingTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()

    }
    
    func setupBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddressListingTableViewController.addAddress))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func addAddress() {
        performSegue(withIdentifier: "addAddressSegue", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
}
