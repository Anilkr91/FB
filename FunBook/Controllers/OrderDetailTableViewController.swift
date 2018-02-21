//
//  OrderDetailTableViewController.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class OrderDetailTableViewController: BaseTableViewController {
    
    var albumId: String = ""
    var albumModel: AlbumDetailModel?
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDateLabel: UILabel!
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumDetail(albumId: albumId)
        print(" ALbum Detail")
        
//        albumNameLabel.text = "Album Name"
//         albumDateLabel.text = "Album Date"
//         albumDescriptionLabel.text = "Album Description"
        
    }
    
    func getAlbumDetail(albumId: String) {
        AlbumDetailGetService.executeRequest(albumId, vc: self) { (response) in
            print(response)
            self.albumModel =  response
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source


   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
   override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            headerTitle.textLabel?.textColor = UIColor(hex: "1b99e6")
        }
    }
}
