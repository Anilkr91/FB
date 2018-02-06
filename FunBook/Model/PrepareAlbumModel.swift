//
//  PrepareAlbumModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import RealmSwift

class PrepareAlbumModel: Object {
   
    dynamic var image: Data? = nil
    dynamic var caption: String = ""
    dynamic var date: String = ""
    dynamic var index: Int = 0
}
