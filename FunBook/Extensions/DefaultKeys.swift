//
//  DefaultKeys.swift
//  StayAPT
//
//  Created by admin on 16/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    
    static let memberLogin = DefaultsKey<[String: Any]?>("memberLogin")
    static let profile = DefaultsKey<[String: Any]?>("profile")
    static let fitnessCenterLogin = DefaultsKey<[String: Any]?>("fitnessCenterLogin")
    static let weightGoal = DefaultsKey<[String: Any]?>("weightGoal")
    static let fcmToken = DefaultsKey<String?>("fcmToken")
}
