//
//  StateModel.swift
//  FunBook
//
//  Created by admin on 09/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct StateModel: JSONDecodable {
    
    let id: String
    let name: String
    
    init?(json: JSON) {
        
        guard let id: String = "stateId" <~~ json,
            let name: String = "stateName" <~~ json else { return nil }
        
        self.id = id
        self.name = name
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "stateId" ~~> self.id,
            "stateName" ~~> self.name
            ])
    }
}
