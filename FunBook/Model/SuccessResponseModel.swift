//
//  SuccessResponseModel.swift
//  FunBook
//
//  Created by admin on 04/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct SuccessResponseModel {
    
    let status: Bool
    let statusCode: Int
    let success: String
    

    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json else { return nil }
        
        self.statusCode = statusCode
        self.status = status
        self.success = success
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success
            
            ])
    }
}
