//
//  AlbumTypeResponseArrayModel.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumTypeResponseArrayModel: JSONDecodable {
    let status: Bool
    let statusCode: Int
    let success: String
    let data: [AlbumTypeModel]
    
    init?(json: JSON) {
        
        guard let status: Bool = "status" <~~ json,
            let statusCode: Int = "statusCode" <~~ json,
            let success: String = "success" <~~ json,
            
            let data: [AlbumTypeModel] = "data.type" <~~ json else { return nil }
        
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
            "data.type" ~~> self.data
            ])
    }
}
