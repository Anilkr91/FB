//
//  RegisterRequestModel.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss
struct RegisterModel {
    
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "email" ~~> self.email,
            "password" ~~> self.password
            ])
    }
}
