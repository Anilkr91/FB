//
//  AddressRequestModel.swift
//  FunBook
//
//  Created by admin on 09/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AddressRequestModel {
    
    let firstName: String
    let lastName: String
    let address1: String
    let address2: String
    let subUrb: String
    let state: String
    let country: String
    let postalCode: String
    
    init(firstName: String, lastName: String, address1: String, address2: String, subUrb: String, state: String, country: String, postalCode: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.address1 = address1
        self.address2 = address2
        self.subUrb = subUrb
        self.state = state
        self.country = country
        self.postalCode = postalCode
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "fName" ~~> self.firstName,
            "lName" ~~> self.lastName,
            "streetAdd1" ~~> self.address1,
            "streetAdd2" ~~> self.address2,
            "suburb" ~~> self.subUrb,
            "state" ~~> self.state,
            "country" ~~> self.country,
            "postalCode" ~~> self.postalCode
            ])
    }
}


