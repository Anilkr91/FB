//
//  DeviceType+Helper.swift
//  StayAPT
//
//  Created by admin on 11/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class Device {
    
    static func userIntefaceType() -> UIUserInterfaceIdiom {
        
        let type = UIDevice.current.userInterfaceIdiom
        return type
    }
}
