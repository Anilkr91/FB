//
//  UserAlbumDetailTableViewController.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import RealmSwift

class UserAlbumDetailTableViewController: BaseTableViewController {
    
    var album: AlbumModel?
    var albumTypeIndex: String?
    var object: AlbumTypeDetailModel?
    var address: AddressResponseModel?
    var count: Int = 0
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imagesCountLabel: UILabel!
    @IBOutlet weak var blankPagesCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    var albumQuantity: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBarButton()
        
        if let album = album {
            for img in album.images.enumerated() {
                if img.offset == album.coverImage {
                    let image = UIImage(data: img.element.image!)
                    coverImageView.image = image
                    
                }
                count += 1
            }
            albumTitleLabel.text = album.name
//            descriptionLabel.text = album.definition
            
                        descriptionLabel.text = album.description
        }
        
        imagesCountLabel.text = "\(count)"
        
        if let object = object {
            let blank = Int(object.pages)! - count
           blankPagesCountLabel.text = "\(blank)"
        }
        
        if let address = address {
            addressLabel.text = "\(address.Address1) \(address.Address2) \(address.subUrb) \(address.stateName) \(address.postalCode)"
        }
        saveAlbumtoRealmDB()
    }
    
    func saveAlbumtoRealmDB() {
        
        let realm = try! Realm()
        try! realm.write {
            album!.albumQuantity = albumQuantity
            realm.add(album!)
        }
    }
    
    func setupBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AlbumTypeDetailTableViewController.dismissModally))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissModally() {
        performSegue(withIdentifier: "showShippingSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showShippingSegue" {
            
            let dvc = segue.destination as! ShippingChargesTableViewController
            dvc.object = object
            dvc.album = album
            dvc.albumQuantity = albumQuantity
        }
    }
    
    @IBAction func addAlbumButton(_ sender: Any) {
        albumQuantity += 1
        quantityLabel.text = "\(albumQuantity)"
        saveAlbumtoRealmDB()
    }
    
    @IBAction func subtractAlbumButton(_ sender: Any) {
        
        if albumQuantity == 1 {
            showAlert("", message: "quantity should be at least one")
        } else {
            albumQuantity -= 1
            quantityLabel.text = "\(albumQuantity)"
        }
        saveAlbumtoRealmDB()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 25
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 25
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
