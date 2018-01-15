//
//  AlbumDetailModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumDetailModel: Gloss.Decodable {
    
    let deviceID: String
    let email: String
    let name: String
    let picture: String
    let userID: String
    let userToken: String
    
    init?(json: JSON) {
        // User
        guard let deviceID: String = "deviceID" <~~ json,
            let email: String = "email" <~~ json,
            let name: String = "name" <~~ json,
            let picture: String = "picture" <~~ json,
            let userID: String = "userID" <~~ json,
            let userToken: String = "userToken" <~~ json else { return nil }
        
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
