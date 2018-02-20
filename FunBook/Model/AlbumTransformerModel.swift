//
//  AlbumTransformerModel.swift
//  FunBook
//
//  Created by admin on 11/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

//import UIKit
//import RealmSwift
//
//struct AlbumTransformerModel {
//
//    // Album Properties
//    let name: String
//    let definition: String
//    let date: String
//
//    // Album coverImage
//    let coverImage: Int
//
//    // Album captionBool for setting the same caption to all images
//    let isCaptionSetToAll: Bool = false
//
//    // Album Images
//    let images: [PrepareAlbumModel]
//
//    // Shipping details
//    let shipping: ShippingRealmModel
//    //    dynamic var address =
//
//    let albumTypeId: String
//    let albumQuantity: Int
//    let addressId: String
//    let albumPrice: String
//    let albumTotalPrice: String
//}


import UIKit

struct AlbumTransformerModel {
    
    let coverImage: Int
    let isCaptionSetToAll: Bool = false
    let name: String
    let description: String
    let date: String
    let addressId: String
    var images: [PrepareAlbumTransformerModel]
    
    
    init(coverImage: Int, name: String, description: String, date: String,addressId: String , images:  [PrepareAlbumTransformerModel]) {
        
        self.coverImage = coverImage
        self.name = name
        self.description = description
        self.date = date
        self.addressId = addressId
        self.images = images
    }
}

