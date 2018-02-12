//
//  CircleImageView.swift
//  FunBook
//
//  Created by admin on 12/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
class CircleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.width/2;
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(hex: "1DA1F2").cgColor
    }
}
