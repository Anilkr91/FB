//
//  StateListingService+GET.swift
//  FunBook
//
//  Created by admin on 09/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class StateListingGetService {
    static func executeRequest ( vc: UIViewController, completionHandler: @escaping ([CountryModel]) -> Void) {
        
        ProgressBarView.showHUD(textString: "Fetching Please Wait..")
        
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "state", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                print(value)
                
                if let json = StateArrayModel(json: value as! JSON) {
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
