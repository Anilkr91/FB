//
//  ErrorResponseModel.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct ErrorResponseModel {
    
    let email: String?
    let error: String?
    let status: Bool
    let statusCode: Int
    let success: String
    
    // Error
//    let email: String
    
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json else { return nil }
            
            // Error
//            let email: String = "error.email" <~~ json
        
        
        self.email = "error.email" <~~ json
        self.statusCode = statusCode
        self.status = status
        self.success = success
//        self.email = email
        self.error = "error" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "error.email" ~~> self.email,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success,
            "error" ~~> self.error

            // Error
//            "error.email" ~~> self.email
            ])
    }
}
