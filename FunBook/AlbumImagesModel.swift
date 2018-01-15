//
//  AlbumImagesModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumImagesModel: Gloss.Decodable {
    
    let small: String
    let large: String
    let caption: String
    
    init?(json: JSON) {
        
        guard let small: String = "small" <~~ json,
            let large: String = "large" <~~ json,
            let caption: String = "caption" <~~ json else { return nil }
        
        self.small = small
        self.large = large
        self.caption = caption
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "small" ~~> self.small,
            "large" ~~> self.large,
            "caption" ~~> self.caption
            
            ])
    }
}
