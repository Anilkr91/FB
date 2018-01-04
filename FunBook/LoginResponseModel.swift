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
    let deviceID: String
    let email: String
    let name: String
    let picture: String
    let userID: String
    let userToken: String
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let error: String = "error" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json,
            
            // User
            let deviceID: String = "data.userDetail.deviceID" <~~ json,
            let email: String = "data.userDetail.email" <~~ json,
            let name: String = "data.userDetail.name" <~~ json,
            let picture: String = "data.userDetail.picture" <~~ json,
            let userID: String = "data.userDetail.userID" <~~ json,
            let userToken: String = "data.userDetail.userToken" <~~ json else { return nil }
        
        self.error = error
        self.status = status
        self.statusCode = statusCode
        self.success = success
        
        // User
        self.deviceID = deviceID
        self.email = email
        self.name = name
        self.picture = picture
        self.userID = userID
        self.userToken = userToken
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "error" ~~> self.error,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success,
            
            // User
            "deviceID" ~~> self.deviceID,
            "email" ~~> self.email,
            "name" ~~> self.name,
            "picture" ~~> self.picture,
            "userID" ~~> self.userID,
            "userToken" ~~> self.userToken
            
            ])
    }
}
