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
