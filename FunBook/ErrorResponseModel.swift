//
//  ErrorResponseModel.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct ErrorResponseModel {
    
    let error: String
    let status: Bool
    let statusCode: Int
    let success: String
    
    // Error
//    let deviceID: String
    let email: String
    
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let error: String = "error" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json,
            
            // Error
            let email: String = "error.email" <~~ json else { return nil }
        
        
        self.error = error
        self.statusCode = statusCode
        self.status = status
        self.success = success
        self.email = email
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "error" ~~> self.error,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success,
            
            // Error
            "error.email" ~~> self.email
            ])
    }
}
