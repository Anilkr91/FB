//
//  PrepareAlbumModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit


struct PrepareAlbumModel {
    
    let image: UIImage
    let caption: String
    let date: String
    let index: Int
    
    
    init(image: UIImage, caption: String, date: String, index: Int) {
        
        self.image = image
        self.caption = caption
        self.date = date
        self.index = index
    }
}
