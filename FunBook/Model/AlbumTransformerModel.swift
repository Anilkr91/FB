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


//dynamic var name: String = ""
//dynamic var definition: String = ""
//dynamic var date: String = ""
//dynamic var status: String = AlbumStatus.Pending.rawValue

// Album coverImage
//dynamic var coverImage: Int = 0

// Album captionBool for setting the same caption to all images
//dynamic var isCaptionSetToAll: Bool = false

// Album Images
//let images = List<PrepareAlbumModel>()

// Shipping details
//dynamic var shipping: ShippingRealmModel?
//    dynamic var address =

//dynamic var albumTypeId: String = ""
//dynamic var albumQuantity: Int = 1
//dynamic var addressId: String = ""
//dynamic var albumPrice: String = ""
//dynamic var albumTotalPrice: String = ""
//dynamic var paypalResponseId: String = ""


import UIKit

struct AlbumTransformerModel {
    
    let coverImage: Int
    let isCaptionSetToAll: Bool = false
    let name: String
    let description: String
    let date: String
    let addressId: String
    var images: [PrepareAlbumTransformerModel]
    
    
    // create album properties
    let albumTypeId: String
    let albumQuantity: Int
    let albumPrice: String
    let albumTotalPrice: String
    let paypalResponseId: String
    let shippingId: String
    
    init(coverImage: Int, name: String, description: String, date: String,addressId: String , images:  [PrepareAlbumTransformerModel], albumTypeId: String, albumQuantity: Int, albumPrice: String, albumTotalPrice: String, paypalResponseId: String, shippingId: String) {
        
        self.coverImage = coverImage
        self.name = name
        self.description = description
        self.date = date
        self.addressId = addressId
        self.images = images
        self.albumTypeId = albumTypeId
        self.albumQuantity = albumQuantity
        self.albumPrice = albumPrice
        self.albumTotalPrice = albumTotalPrice
        self.paypalResponseId = paypalResponseId
        self.shippingId = shippingId
    }
}

