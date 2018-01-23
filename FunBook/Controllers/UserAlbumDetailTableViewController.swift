//
//  UserAlbumDetailTableViewController.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class UserAlbumDetailTableViewController: BaseTableViewController {
    
    var album: AlbumModel?
    var albumTypeIndex: String?
    var object: AlbumTypeDetailModel?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var albumPriceLabel: UILabel!
    @IBOutlet weak var paperTypeLabel: UILabel!
    @IBOutlet weak var paperSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let album = album {
            for img in album.images.enumerated() {
                if img.offset == album.coverImage {
                    coverImageView.image = img.element.image
                }
            }
            albumTitleLabel.text = album.name
            descriptionLabel.text = album.description
        }
        
        if let object = object {
            pagesCountLabel.text = object.pages
            albumPriceLabel.text = object.amount
            paperTypeLabel.text = object.paperName
            paperSizeLabel.text = object.paperSize
        }
    }
    
    func setupBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AlbumTypeDetailTableViewController.dismissModally))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissModally() {
        performSegue(withIdentifier: "showUserAlbumDetailSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShippingSegue" {
        
            let dvc = segue.destination as! ShippingChargesTableViewController
            dvc.object = object
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
