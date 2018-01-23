//
//  ShippingChargesTableViewController.swift
//  FunBook
//
//  Created by admin on 23/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class ShippingChargesTableViewController: BaseTableViewController {
    
    var album: AlbumModel?
    var object: AlbumTypeDetailModel?
    var array: [ShippingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShippingPrices()
        setupBarButton()
    }
    
    func getShippingPrices() {
        ShippingPriceGetService.executeRequest(vc: self) { (response) in
            self.array = response
            self.tableView.reloadData()
        }
    }
    
    func setupBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AlbumTypeDetailTableViewController.dismissModally))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissModally() {
        performSegue(withIdentifier: "showCheckoutSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShippingChargesTableViewCell
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckoutSegue" {
            
//            let dvc = segue.destination as! CheckOutTableViewController
//            dvc.object = object
        }
    }
}
