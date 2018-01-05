//
//  LoginUtils.swift
//  StayAPT
//
//  Created by admin on 16/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import SwiftyUserDefaults

class LoginUtils {
    
    class func setCurrentMemberUser(_ user: UserModel) {
        if let login = getCurrentMemberUserLogin() {
            let tmpLogin = login
            //tmpLogin.user = user
            setCurrentMemberUserLogin(tmpLogin)
        } else {
            setCurrentMemberUserLogin(user)
        }
    }
    
    class func setCurrentMemberUserLogin(_ login: UserModel?) {
        if let login = login {
            
            Defaults[.user] = login.toJSON()
        } else {
            Defaults.removeAll()
        }
    }
    
    class func getCurrentMemberUserLogin() -> UserModel? {
        if let json = Defaults[.user], let user = UserModel(json: json) {
            return user
        }
        return nil
    }
}
