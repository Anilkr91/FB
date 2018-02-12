//
//  AlbumTableViewCell.swift
//  FunBook
//
//  Created by admin on 11/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumTableViewCell : UITableViewCell{
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDescription: UILabel!
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
    
    var info: AlbumResponseModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension AlbumTableViewCell {
    func didSetCategory(_ info: AlbumResponseModel) {
        
        let imageUrl:String = info.thumbNail.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        
        let placeholderImage = UIImage(named: "loader")
        albumImageView.kf.setImage(with: url, placeholder: placeholderImage)
        albumNameLabel.text = info.albumName
        albumDescription.text = info.albumDescription
        dateLabel.text = info.albumDate
    }
}
