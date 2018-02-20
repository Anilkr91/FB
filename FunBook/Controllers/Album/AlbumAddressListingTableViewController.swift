//
//  AlbumAddressListingTableViewController.swift
//  FunBook
//
//  Created by admin on 09/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumAddressListingTableViewController: BaseTableViewController {
    
    var array: [AddressResponseModel] = []
    var album: AlbumModel?
    var object: AlbumTypeDetailModel?
    var address: AddressResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AllAddressGetService.executeRequest(vc: self) { (response) in
            self.array = response
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addAddressButton(_ sender: Any) {
        performSegue(withIdentifier: "addAddressSegue", sender: self)
    }
    
    func saveAlbumtoRealmDB(address: AddressResponseModel) {
        
        let realm = try! Realm()
        try! realm.write {
            album!.addressId = address.id
            realm.add(album!)
            performSegue(withIdentifier: "showUserAlbumDetailSegue", sender: self)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserAlbumDetailSegue" {
            let dvc = segue.destination as! UserAlbumDetailTableViewController
            dvc.album = album
            dvc.object = object
            dvc.address = address
        
        } else if segue.identifier == "addAddressSegue" {
        
            let nvc = segue.destination as? UINavigationController
            let dvc = nvc?.viewControllers[0] as? AddAddressTableViewController
            dvc?.vc = self
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressListingTableViewCell
        cell.info = array[indexPath.section]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        address = array[indexPath.section]
        saveAlbumtoRealmDB(address: address!)
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
}
