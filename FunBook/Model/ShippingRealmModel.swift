//
//  ShippingRealmModel.swift
//  FunBook
//
//  Created by admin on 08/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import RealmSwift

class ShippingRealmModel: Object {
    
    // Shipping Properties
    dynamic var id: String = ""
    dynamic var shippingAmount: String = ""
    dynamic var shippingTitle: String = ""
}
