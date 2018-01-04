//
//  LoginUtils.swift
//  StayAPT
//
//  Created by admin on 16/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

/*
import SwiftyUserDefaults
//import FBSDKLoginKit
//import GoogleSignIn

class LoginUtils {
    
    class func setCurrentMemberUser(_ user: LoginModelResponse) {
        if let login = getCurrentMemberUserLogin() {
            let tmpLogin = login
            //tmpLogin.user = user
            setCurrentMemberUserLogin(tmpLogin)
        } else {
            setCurrentMemberUserLogin(user)
        }
    }
    
    class func setCurrentFitnessCenter(_ user: FCLoginResponse) {
        if let login = getCurrentFitnessCenterUserLogin() {
            let tmpLogin = login
            setCurrentFitnessCenterUserLogin(tmpLogin)
        } else {
           setCurrentFitnessCenterUserLogin(user)
        }
    }
    
    class func setCurrentMemberUserLogin(_ login: LoginModelResponse?) {
        if let login = login {
            
            Defaults[.memberLogin] = login.toJSON()
        } else {
            Defaults.removeAll()
        }
    }
    
    class func setCurrentFitnessCenterUserLogin(_ login: FCLoginResponse?) {
        if let login = login {
            
            Defaults[.fitnessCenterLogin] = login.toJSON()
        } else {
            Defaults.removeAll()
            
            GIDSignIn.sharedInstance().signOut()
            let loginManager: FBSDKLoginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
    }
    
    class func getCurrentMemberUserLogin() -> LoginModelResponse? {
        if let json = Defaults[.memberLogin], let user = LoginModelResponse(json: json) {
            return user
        }
        return nil
    }
    
    class func getCurrentFitnessCenterUserLogin() -> FCLoginResponse? {
     
        if let json = Defaults[.fitnessCenterLogin], let user = FCLoginResponse(json: json) {
            return user
        }
        return nil
    }
    
    class func setCurrentUserProfile(_ profile: ProfileResponse) {
        
        if let profile = getCurrentUserProfile() {
            let tmpProfile = profile
            //tmpLogin.user = user
            setCurrentUserProfileLogin(tmpProfile)
        } else {
            setCurrentUserProfileLogin(profile)
        }
    }
    
    class func setCurrentUserProfileLogin(_ profile: ProfileResponse?) {
        if let profile = profile {
            
            Defaults[.profile] = profile.toJSON()
        } else {
            Defaults.removeAll()
            
            GIDSignIn.sharedInstance().signOut()
            let loginManager: FBSDKLoginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
    }
    
    class func getCurrentUserProfile() -> ProfileResponse? {
        
        if let json = Defaults[.profile], let profile = ProfileResponse(json: json) {
            return profile
        }
        return nil
    }
}

 */
