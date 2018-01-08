//
//  ForgotPasswordService+POST.swift
//  FunBook
//
//  Created by admin on 05/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class ForgotPasswordPostService {
    
    static func executeRequest (_ params:[String: Any], vc: UIViewController, completionHandler: @escaping (SuccessResponseModel?, ErrorResponseModel?) -> Void) {
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "forgotPassword", method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                print(value)
                
                if let json = SuccessResponseModel(json: value as! JSON) {
                    
                    if json.status == true {
                        completionHandler(json, nil)
                        
                    }
                }
                
                
                if let error = ErrorResponseModel(json: value as! JSON) {
                    
                    if error.status == false {
                         completionHandler(nil, error)
                        
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
}
