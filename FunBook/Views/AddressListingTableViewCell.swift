//
//  AddressListingTableViewCell.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

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
    
    var info: AddressResponseModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension AddressListingTableViewCell {
    func didSetCategory(_ info: AddressResponseModel) {

        if info.is_default == "1" {
          defaultAddressLabel.text = ""
//            backgroundColor = UIColor(hex: "33AEF5")
       
        } else if info.is_default == "0" {
           defaultAddressLabel.text = ""
//            backgroundColor = UIColor(hex: "0BA425")
        
        }

        addressTitleLabel.text = "\(info.firstName) \(info.lastName)"
        addressLabel.text = "\(info.Address1), \(info.Address2), \(info.subUrb), \(info.stateName), \(info.countryName) \n PinCode: \(info.postalCode)"
    }
}
