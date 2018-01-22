//
//  AlbumTypeDetailModel.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumTypeDetailModel: JSONDecodable {
    
    let id: String
    let coverImage: String
    let title: String
    let description: String
    let pages: String
    let amount: String
    let paperSize: String
    let paperName: String
    
    init?(json: JSON) {
        
        guard let id: String = "id" <~~ json,
            let coverImage: String = "coverImage" <~~ json,
            let title: String = "title" <~~ json,
            let description: String = "description" <~~ json,
            let pages: String = "pages" <~~ json,
            let amount: String = "amount" <~~ json,
            let paperSize: String = "paper_size" <~~ json,
            let paperName: String = "paperName" <~~ json else { return nil }
        
        
        self.id = id
        self.coverImage = coverImage
        self.title = title
        self.description = description
        self.pages = pages
        self.amount = amount
        self.paperSize = paperSize
        self.paperName = paperName
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "id" ~~> self.id,
            "coverImage" ~~> self.coverImage,
            "title" ~~> self.title,
            "description" ~~> self.description,
            "pages" ~~> self.pages,
            "amount" ~~> self.amount,
            "paper_size" ~~> self.paperSize,
            "paperName" ~~> self.paperName
            
            ])
    }
}
