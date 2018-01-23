//
//  AddressListingTableViewCell.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//
//
//import UIKit
//
//class AddressListingTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var defaultAddressLabel: UILabel!
//    @IBOutlet weak var addressTitleLabel: UILabel!
//    @IBOutlet weak var addressLabel: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}


import UIKit

class AddressListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var defaultAddressLabel: UILabel!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
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

extension AddressListingTableViewCell {
    func didSetCategory(_ info: AlbumTypeModel) {
        
//        let imageUrl:String = info.coverImage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//        let url = URL(string: imageUrl)
//        
//        let placeholderImage = UIImage(named: "loader")
//        coverImageView.kf.setImage(with: url, placeholder: placeholderImage)
        defaultAddressLabel.text = info.title
        addressTitleLabel.text = info.pages
        addressLabel.text = info.amount
//        descriptionLabel.text = info.description
    }
}
