//
//  EditAddressService+POST.swift
//  FunBook
//
//  Created by admin on 22/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class EditAddressPostService {
    static func executeRequest (addressId:String, params:[String: Any], vc: UIViewController, completionHandler: @escaping (LoginResponseModel) -> Void) {
        
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "profile/update_address/\(addressId)", method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
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
