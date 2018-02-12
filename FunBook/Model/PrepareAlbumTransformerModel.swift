//
//  PrepareAlbumTransformerModel.swift
//  FunBook
//
//  Created by admin on 11/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

//import UIKit
//import RealmSwift
//
//class PrepareAlbumTransformerModel: Object {
//
//    let image: UIImage
//    let caption: String = ""
//    let date: String = ""
//    let index: Int = 0
//}


import UIKit

struct PrepareAlbumTransformerModel  {
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
