//
//  AlbumTypeTableViewCell.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AlbumTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pagesCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
    
    var info: AlbumTypeModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension AlbumTypeTableViewCell {
    func didSetCategory(_ info: AlbumTypeModel) {
        
        let imageUrl:String = info.coverImage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        
        let placeholderImage = UIImage(named: "loader")
        coverImageView.kf.setImage(with: url, placeholder: placeholderImage)
        titleLabel.text = info.title
        pagesCountLabel.text = "Pages: \(info.pages)"
        priceLabel.text = "Price: $\(info.amount)"
        descriptionLabel.text = info.description
    }
}
