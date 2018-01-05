//
//  LoginResponseModel.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct LoginResponseModel: Gloss.Decodable {
    
    let error: String
    let status: Bool
    let statusCode: Int
    let success: String
    
     // User
    let user: UserModel
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let error: String = "error" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json,
            
            // User
            let user: UserModel = "data.userDetail" <~~ json else { return nil }
        
        self.error = error
        self.status = status
        self.statusCode = statusCode
        self.success = success
        
        // User
        self.user = user
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "error" ~~> self.error,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success,
            
            // User
            "data.userDetail" ~~> self.user
            ])
    }
}
