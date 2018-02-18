//
//  AlbumDetailTableViewController.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: BaseTableViewController {
    
    var albumId: String = ""
    var albumModel: [AlbumImagesModel] = []
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDateLabel: UILabel!
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getAlbumDetail(albumId: albumId)
        print(" ALbum Detail")
        
        albumNameLabel.text = "Album Name"
         albumDateLabel.text = "Album Date"
         albumDescriptionLabel.text = "Album Description"
        
    }
    
    func getAlbumDetail(albumId: String) {
        
        AlbumDetailGetService.executeRequest(albumId, vc: self) { (response) in
            self.albumModel =  response
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
//   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumDetailTableViewCell
//        cell.info = albumModel[indexPath.section]
//        return cell
//    }

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
