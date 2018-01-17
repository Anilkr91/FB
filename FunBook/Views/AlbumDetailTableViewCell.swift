//
//  AlbumDetailTableViewCell.swift
//  FunBook
//
//  Created by admin on 17/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumDetailTableViewCell : UITableViewCell{
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        //        accessoryType = selected ? .checkmark : .none
    }
    
    var info: AlbumImagesModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension AlbumDetailTableViewCell {
    func didSetCategory(_ info: AlbumImagesModel) {
        
        let imageUrl:String = info.small.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        
        let placeholderImage = UIImage(named: "loader")
        albumImageView.kf.setImage(with: url, placeholder: placeholderImage)
        captionLabel.text = info.caption
        dateLabel.text = info.date
    }
}

