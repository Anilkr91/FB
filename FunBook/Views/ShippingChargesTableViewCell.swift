//
//  ShippingChargesTableViewCell.swift
//  FunBook
//
//  Created by admin on 23/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class ShippingChargesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
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
    
    var info: ShippingModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension ShippingChargesTableViewCell {
    func didSetCategory(_ info: ShippingModel) {
        
        titleLabel.text = info.shippingTitle
        priceLabel.text = info.shippingAmount
    }
}


