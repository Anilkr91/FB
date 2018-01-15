//
//  AlbumResponseModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumResponseModel: Gloss.Decodable {
    
    let albumID: String
    let albumName: String
    let thumbNail: String
    let created: String
    
    
    init?(json: JSON) {
        
        guard let albumID: String = "albumID" <~~ json,
            let albumName: String = "albumName" <~~ json,
            let thumbNail: String = "thumb" <~~ json,
            let created: String = "created" <~~ json else { return nil }
        
        self.albumID = albumID
        self.albumName = albumName
        self.thumbNail = thumbNail
        self.created = created
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            // User
            "albumID" ~~> self.albumID,
            "albumName" ~~> self.albumName,
            "thumb" ~~> self.thumbNail,
            "created" ~~> self.created
            
            ])
    }
}
