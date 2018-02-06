//
//  AlbumTypeTableViewController.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumTypeTableViewController: BaseTableViewController {
    
    var album: AlbumModel?
    var array: [AlbumTypeModel] = []
    var albumTypeIndex: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumType()
        saveAlbumtoRealmDB()
    }
    
    func saveAlbumtoRealmDB() {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(album!)
        }
    }
    
    func getAlbumType() {
        AlbumTypeGetService.executeRequest(vc: self) { (response) in
            self.array =  response
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumTypeTableViewCell
        cell.info = array[indexPath.section]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumTypeIndex = array[indexPath.section].id
        performSegue(withIdentifier: "showAlbumDetailTypeSegue", sender: self)
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
        
        if segue.identifier == "showAlbumDetailTypeSegue" {
            
            let dvc = segue.destination as! AlbumTypeDetailTableViewController
            dvc.album = album
            dvc.albumTypeIndex = albumTypeIndex
        }
    }
}
