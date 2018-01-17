//
//  OTPVerifyModel.swift
//  FunBook
//
//  Created by admin on 08/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct OTPVerifyModel: JSONDecodable {
    
    let error: String
    let status: Bool
    let statusCode: Int
    let success: String
    let passwordToken: String
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let error: String = "error" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json,
            let passwordToken: String = "data.passwordToken" <~~ json else { return nil }
        
        self.error = error
        self.status = status
        self.statusCode = statusCode
        self.success = success
        self.passwordToken = passwordToken
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "error" ~~> self.error,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success,
            "data.passwordToken" ~~> self.passwordToken
            ])
    }
}
