//
//  ShippingModel.swift
//  FunBook
//
//  Created by admin on 23/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct  ShippingModel: JSONDecodable {
    
    let id: String
    let shippingAmount: String
    let shippingTitle: String
    
    init?(json: JSON) {
        
        guard let id: String = "id" <~~ json,
            let shippingAmount: String = "shippingAmnt" <~~ json,
            let shippingTitle: String = "shippingTitle" <~~ json else { return nil }
        
        self.id = id
        self.shippingAmount = shippingAmount
        self.shippingTitle = shippingTitle
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "id" ~~> self.id,
            "shippingAmnt" ~~> self.shippingAmount,
            "shippingTitle" ~~> self.shippingTitle
            
            ])
    }
}
