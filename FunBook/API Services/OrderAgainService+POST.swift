//
//  OrderAgainService+POST.swift
//  FunBook
//
//  Created by admin on 22/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class OrderAgainPostService {
    static func executeRequest (_ params:[String: Any], vc: UIViewController, completionHandler: @escaping (AlbumDetailModel) -> Void) {
        
        ProgressBarView.showHUD(textString: "Please Wait..")
        
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "profile/order_again", method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
                
            case .success(let value) :
                
                print(value)
                
                if let json = AlbumDetailResponseModel(json: value as! JSON) {
                    completionHandler(json.data)
                    ProgressBarView.hideHUD()
                }
                
            case .failure(let error):
                ProgressBarView.hideHUD()
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
}

