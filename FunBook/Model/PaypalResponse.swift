//
//  PaypalResponse.swift
//  FunBook
//
//  Created by admin on 24/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct PaypalResponse: JSONDecodable {
    
    let id: String
    let intent: String
    let state: String
    
    init?(json: JSON) {
        
        guard let id: String = "response.id" <~~ json,
            let intent: String = "response.intent" <~~ json,
            let state: String = "response.state" <~~ json else { return nil }
        
        self.id = id
        self.intent = intent
        self.state = state
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "response.id" ~~> self.id,
            "response.intent" ~~> self.intent,
            "response.state" ~~> self.state
            
            ])
    }
}


//
//[AnyHashable("response"): {
//    "create_time" = "2018-01-24T10:06:05Z";
//    id = "PAY-0MW83797WE183772NLJUFVDI";
//    intent = authorize;
//    state = created;
//    }, AnyHashable("response_type"): payment, AnyHashable("client"): {
//        environment = sandbox;
//        "paypal_sdk_version" = "2.18.0";
//        platform = iOS;
//        "product_name" = "PayPal iOS SDK";
//    }]

