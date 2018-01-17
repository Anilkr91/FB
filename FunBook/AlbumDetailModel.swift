//
//  AlbumDetailModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumDetailModel: JSONDecodable {
    
    let albumID: String
    let albumName: String
    let address: String
    let created: String
    let images: [AlbumImagesModel]
    
    init?(json: JSON) {
        // User
        guard let albumID: String = "albumID" <~~ json,
        let albumName: String = "albumName" <~~ json,
        let address: String = "address" <~~ json,
        let created: String = "created" <~~ json,
        let images: [AlbumImagesModel] = "images" <~~ json else { return nil }
        
        self.albumID = albumID
        self.albumName = albumName
        self.address = address
        self.created = created
        self.images = images
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "albumID" ~~> self.albumID,
            "albumName" ~~> self.albumName,
            "address" ~~> self.address,
            "created" ~~> self.created,
            "images" ~~> self.images
            
            ])
    }
}
