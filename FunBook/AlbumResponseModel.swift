//
//  AlbumResponseModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumResponseModel: JSONDecodable {
    
    let albumID: String
    let albumName: String
    let thumbNail: String
    let albumDate: String
    let albumDescription: String
    
    init?(json: JSON) {
        
        guard let albumID: String = "albumID" <~~ json,
            let albumName: String = "albumName" <~~ json,
            let thumbNail: String = "thumb" <~~ json,
            let albumDate: String = "albumDate" <~~ json,
            let albumDescription: String = "albumDescription" <~~ json else { return nil }
        
        self.albumID = albumID
        self.albumName = albumName
        self.thumbNail = thumbNail
        self.albumDate = albumDate
        self.albumDescription =  albumDescription
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "albumID" ~~> self.albumID,
            "albumName" ~~> self.albumName,
            "thumb" ~~> self.thumbNail,
            "albumDate" ~~> self.albumDate,
            "albumDescription"  ~~> self.albumDescription
            
            ])
    }
}
