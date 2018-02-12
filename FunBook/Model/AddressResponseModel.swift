//
//  AddressResponseModel.swift
//  FunBook
//
//  Created by admin on 09/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AddressResponseModel: JSONDecodable {
    
    let id: String
    let userId: String
    let firstName: String
    let lastName: String
    let Address1: String
    let Address2: String
    let subUrb: String
    let state: String
    let postalCode: String
    let is_default: String
    let stateName: String
    
    init?(json: JSON) {
        
        guard let id: String = "id" <~~ json,
            let userId: String = "userId" <~~ json,
            let firstName: String = "fName" <~~ json,
            let lastName: String = "lName" <~~ json,
            let Address1: String = "streetAdd1" <~~ json,
            let Address2: String = "streetAdd2" <~~ json,
            let subUrb: String = "suburb" <~~ json,
            let state: String = "state" <~~ json,
            let postalCode: String = "postalCode" <~~ json,
            let is_default: String = "is_default" <~~ json,
            let stateName: String = "stateName" <~~ json else { return nil }
        
        self.id = id
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.Address1 = Address1
        self.Address2 = Address2
        self.subUrb = subUrb
        self.state = state
        self.postalCode = postalCode
        self.is_default = is_default
        self.stateName = stateName
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "id" ~~> self.id,
            "userId" ~~> self.userId,
            "fName" ~~> self.firstName,
            "lName" ~~> self.lastName,
            "streetAdd1" ~~> self.Address1,
            "streetAdd2" ~~> self.Address2,
            "suburb" ~~> self.subUrb,
            "state" ~~> self.state,
            "postalCode" ~~> self.postalCode,
            "is_default" ~~> self.is_default,
            "stateName" ~~> self.stateName
            
            ])
    }
}
