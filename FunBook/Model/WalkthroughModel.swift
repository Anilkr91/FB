//
//  WalkthroughModel.swift
//  FunBook
//
//  Created by admin on 14/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

struct WalkthroughModel {
    
    var name: String
    var heading: String
    var text: String
    
    init(name:String, heading: String, text: String) {
        self.name = name
        self.heading = heading
        self.text = text
    }
}

