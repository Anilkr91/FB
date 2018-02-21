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
    dynamic var status: String = AlbumStatus.Pending.rawValue
    
    // Album coverImage
    dynamic var coverImage: Int = 0
    
    // Album captionBool for setting the same caption to all images
    dynamic var isCaptionSetToAll: Bool = false
    
    // Album Images
    let images = List<PrepareAlbumModel>()
    
    // Shipping details
    dynamic var shipping: ShippingRealmModel?
//    dynamic var address = 
    
    dynamic var albumTypeId: String = ""
    dynamic var albumQuantity: Int = 1
    dynamic var addressId: String = ""
    dynamic var albumPrice: String = ""
    dynamic var albumTotalPrice: String = ""
    dynamic var paypalResponseId: String = ""
}
