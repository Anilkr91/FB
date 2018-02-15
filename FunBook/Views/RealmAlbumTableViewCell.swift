//
//  RealmAlbumTableViewCell.swift
//  FunBook
//
//  Created by admin on 06/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class RealmAlbumTableViewCell : UITableViewCell{
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
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
    
    var info: AlbumModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension RealmAlbumTableViewCell {
    func didSetCategory(_ info: AlbumModel) {
        
        for img in info.images.enumerated() {
            
            if info.coverImage == img.element.index {
                albumImageView.image = UIImage(data: img.element.image!)
            }
        }
        albumNameLabel.text = info.name
        albumDescriptionLabel.text = info.definition
        dateLabel.text = info.date
        statusLabel.text = info.status
        
    }
}
