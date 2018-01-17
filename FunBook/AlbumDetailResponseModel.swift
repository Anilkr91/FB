//
//  AlbumDetailResponseModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumDetailResponseModel: JSONDecodable {
   
    let status: Bool
    let statusCode: Int
    let success: String
    let data: AlbumDetailModel
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json,
            
            let data: AlbumDetailModel = "data.album" <~~ json else { return nil }
        
        self.status = status
        self.statusCode = statusCode
        self.success = success
        self.data = data
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "statusCode" ~~> self.statusCode,
            "success" ~~> self.success,
            "data.album" ~~> self.data
            ])
    }
}
