//
//  AlbumModel.swift
//  FunBook
//
//  Created by admin on 17/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumModel: Object {
    
    // Album Properties
    dynamic var name: String = ""
    dynamic var definition: String = ""
    dynamic var date: String = ""
    
    // Album coverImage
    dynamic var coverImage: Int = 0
    
    // Album captionBool for setting the same caption to all images
    dynamic var isCaptionSetToAll: Bool = false
    
    // Album Images
    let images = List<PrepareAlbumModel>()
    
//    dynamic var images: [PrepareAlbumModel]
    
//    init(coverImage: Int, name: String, description: String, date: String, images:  [PrepareAlbumModel]) {
//
//        self.coverImage = coverImage
//        self.name = name
//        self.description = description
//        self.date = date
//        self.images = images
//    }
}
