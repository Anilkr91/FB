//
//  AlbumModel.swift
//  FunBook
//
//  Created by admin on 17/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

struct AlbumModel {
    
    var coverImage: Int
    let isCaptionSetToAll: Bool = false
    let name: String
    let description: String
    let date: String
    var images: [PrepareAlbumModel]
    
    init(coverImage: Int, name: String, description: String, date: String, images:  [PrepareAlbumModel]) {
        
        self.coverImage = coverImage
        self.name = name
        self.description = description
        self.date = date
        self.images = images
    }
}
