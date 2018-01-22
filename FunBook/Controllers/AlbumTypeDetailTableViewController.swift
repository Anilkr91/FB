//
//  AlbumTypeDetailTableViewController.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AlbumTypeDetailTableViewController: BaseTableViewController {
    
    var album: AlbumModel?
    var albumTypeIndex: String?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var albumPriceLabel: UILabel!
    @IBOutlet weak var paperTypeLabel: UILabel!
    @IBOutlet weak var paperSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = albumTypeIndex {
            AlbumTypeDetailGetService.executeRequest(id, vc: self) { (response) in
                self.setUpView(info: response)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView(info: AlbumTypeDetailModel) {

        let imageUrl:String = info.coverImage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        let placeholderImage = UIImage(named: "loader")
        coverImageView.kf.setImage(with: url, placeholder: placeholderImage)
        
        albumTitleLabel.text = info.title
        descriptionLabel.text = info.description
        pagesCountLabel.text = info.pages
        albumPriceLabel.text = info.amount
        paperTypeLabel.text = info.paperName
        paperSizeLabel.text = info.paperSize

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
