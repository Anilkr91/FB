//
//  CountryModel.swift
//  FunBook
//
//  Created by admin on 15/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct CountryModel: JSONDecodable {
    
    let countryId: String
    let countryName: String
    let states: [StateModel]
    
    init?(json: JSON) {
        
        guard let countryId: String = "countryId" <~~ json,
            let countryName: String = "countryName" <~~ json,
        let states: [StateModel]  = "state" <~~ json else { return nil }
        
        self.countryId = countryId
        self.countryName = countryName
        self.states = states
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "countryId" ~~> self.countryId,
            "countryName" ~~> self.countryName,
            "state" ~~> self.states
            
            ])
    }
}
