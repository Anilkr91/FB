//
//  OrderHistoryTableViewController.swift
//  FunBook
//
//  Created by admin on 06/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class OrderHistoryTableViewController: BaseTableViewController {
    
    var albumModel: [AlbumResponseModel] = []
    var album: AlbumResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetch all albums
        getAllAlbums()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return albumModel.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumTableViewCell
        cell.info = albumModel[indexPath.section]
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        album = albumModel[indexPath.section]
        print(album)
        self.performSegue(withIdentifier: "showOrderDetail", sender: self)
    }
}

extension OrderHistoryTableViewController {
    
    func getAllAlbums() {
        
        AlbumListingGetService.executeRequest(vc: self) { (response) in
            print(response)
            self.albumModel = response
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderDetail" {
        
            let dvc = segue.destination as! OrderDetailTableViewController
            dvc.navigationItem.title = album?.albumName
            dvc.albumId = album!.albumID
        }
    }
}
