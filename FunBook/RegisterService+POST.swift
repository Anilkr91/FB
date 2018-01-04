//
//  RegisterService+POST.swift
//  FunBook
//
//  Created by admin on 28/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class RegisterPostService {
    static func executeRequest (_ params:[String: Any], vc: UIViewController, completionHandler: @escaping (SuccessResponseModel) -> Void) {
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY]
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "register", method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                if let json = SuccessResponseModel(json: value as! JSON) {
                    completionHandler(json)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
}
