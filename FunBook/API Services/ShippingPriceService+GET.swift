//
//  ShippingPriceService+GET.swift
//  FunBook
//
//  Created by admin on 23/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class ShippingPriceGetService {
    static func executeRequest ( vc: UIViewController, completionHandler: @escaping ([ShippingModel]) -> Void) {
        
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "shipping", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
                
            case .success(let value) :
                
                print(value)
                
                if let json = ShippingArrayModel(json: value as! JSON) {
                    completionHandler(json.data)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
}
