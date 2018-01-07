//
//  OTPVerifyService+POST.swift
//  FunBook
//
//  Created by admin on 07/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class OTPVerifyPostService {
    
    static func executeRequest (_ params:[String: Any], vc: UIViewController, completionHandler: @escaping (LoginResponseModel) -> Void) {
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "otpVerify", method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                print(value)
                
                if let json = LoginResponseModel(json: value as! JSON) {
                    completionHandler(json)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
}
